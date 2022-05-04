# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to operate!
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.dates import datetime
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import dag, task
from airflow.operators.python import task, get_current_context
import pendulum
# Pandas to transform data
from pandas import DataFrame
import requests
from pandas import json_normalize
import pandas as pd
from sqlalchemy import create_engine
from datetime import timedelta

# Setting timezone to pacific
local_tz = pendulum.timezone("US/Pacific")
# Setting database name
db_name = "userdata"
# The api that we need to call
NY_API = "https://health.data.ny.gov/resource/xdss-u53e.json?"

# These args will get passed on to each operator
# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Anil',
    'dag_id': 'LOAD_NY_COVID_DLY',
    'start_date': datetime(2020, 3, 1, tzinfo=local_tz),
    'schedule_interval': '0 9 * * *'
}

# Using postgress Hook to get connection url and modifying it to have the right databasename
result = PostgresHook(postgres_conn_id='postgres_new').get_uri().split("/")
result[3] = db_name
dbURI = "/".join(result)

with DAG('LOAD_NY_COVID_DLY', default_args=default_args, catchup=False, template_searchpath='/opt/airflow/') as dag:
    @dag.task
    def getTodayDate():
        """
        gets the current context of Airflow task. This context will be used to get the execution date.

        """
        context = {"test_date": get_current_context()["ds"]}
        print(context)
        return context

    getdate = getTodayDate()

    # Setting task to be retiried twice with a gap of 30 minutes
    @dag.task(default_args={'retries': '2', 'retry_delay': timedelta(minutes=30)})
    def get_ny_covid_data_by_date(test_date):
        """
        Query New York health api to get daily Covid testing data
        :param test_date: Pass a json string ex: {'testdate': '2021-02-07'}
        :return:
        Return a json data.
        """
        json_data = ""
        # Call New York Api to get data
        result = requests.get(NY_API, test_date)
        if result.status_code == 200:
            print("Call to api successful")
            if not result.json():
                raise ValueError(
                    "Data not available for " + test_date['test_date'] + " yet. Please try after sometime")
            # Getting json data from response
            json_data = result.json()
            return json_data
        else:
            print("Error in Api Call")
        return json_data

    @dag.task
    def loaddata(json_data: str):
        """
        This would load data to Postgres Sql by creating Panadas dataframe 
        and tranforming the column names.

        Args:
            json_data (str) :

        """
        # Pandas DataFrame to read json data
        dataframe: DataFrame = json_normalize(json_data)
        # Printing Dthe dataframe to logs
        print(dataframe.head(2))
        # Creating DB engine
        engine = create_engine(dbURI)
        # Adding new column loaddate to Dataframe
        dataframe['loaddate'] = pd.to_datetime('today')
        # Changing column names to match with database table
        dataframe.rename(columns={"test_date": "testdate", "new_positives": "newpositives",
                                  "cumulative_number_of_positives": "cummpositives",
                                  "total_number_of_tests": "totaltests",
                                  "cumulative_number_of_tests": "cummtests",
                                  "test_positive":"testpositive",
                                  "geography":"geography"}, inplace=True)
        # Loading data from dataframe to Postgres table
        dataframe.to_sql("nymaster", engine, index=False,
                         if_exists='append', schema='public')
    # Setting Task dependency
    loaddata(get_ny_covid_data_by_date(getdate))

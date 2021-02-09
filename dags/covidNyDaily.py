from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.dates import datetime
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import dag, task
from airflow.operators.python import task, get_current_context
import pendulum
from pandas import DataFrame
import requests
from pandas import json_normalize
import pandas as pd
from sqlalchemy import create_engine
from datetime import timedelta

local_tz = pendulum.timezone("US/Pacific")
db_name = "userdata"

default_args = {
    'owner': 'Anil',
    'dag_id': 'LOAD_NY_COVID_DLY',
    'start_date': datetime(2020, 3, 1, tzinfo=local_tz),
    'schedule_interval': '0 9 * * *'
}

result = PostgresHook(postgres_conn_id='postgres_new').get_uri().split("/")
result[3] = db_name
dbURI = "/".join(result)

with DAG('LOAD_NY_COVID_DLY', default_args=default_args, catchup=False, template_searchpath='/opt/airflow/') as dag:
    @dag.task
    def getTodayDate():
        context = {"test_date": get_current_context()["ds"]};
        print(context)
        return context

    getdate= getTodayDate()
    @dag.task(default_args = {'retries': '2','retry_delay': timedelta(minutes=30)})
    def get_ny_covid_data_by_date(test_date):
        """
        Query New York health api to get daily Covid testing data
        :param test_date: Pass a json string ex: {'testdate': '2021-02-07'}
        :return:
        Return a pandas Dataframe.
        """
        json_data=""
        #param_date = test_date["testdate"]
        #parameters = {'test_date': '2020-02-09'}
        result = requests.get("https://health.data.ny.gov/resource/xdss-u53e.json?", test_date)
        if result.status_code == 200:
            print("Call to api successful")
            if not result.json():
                raise ValueError("Data not available for "+test_date['test_date']+" yet. Please try after sometime")
            json_data = result.json()
            return json_data
        else:
            print("Error in Api Call")
        return json_data
    
    @dag.task
    def loaddata(json_data: str):
        dataframe: DataFrame = json_normalize(json_data)
        print(dataframe.head(2))
        engine = create_engine(dbURI)
        dataframe['loaddate'] = pd.to_datetime('today')
        dataframe.rename(columns={"test_date": "testdate", "new_positives": "newpositives",
                                  "cumulative_number_of_positives": "cummpositives",
                                  "total_number_of_tests": "totaltests",
                                  "cumulative_number_of_tests": "cummtests"}, inplace=True)
        dataframe.to_sql("nymaster", engine, index=False, if_exists='append', schema='public')
    
    loaddata(get_ny_covid_data_by_date(getdate))





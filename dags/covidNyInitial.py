from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.utils.task_group import TaskGroup
from airflow.utils.dates import days_ago
from airflow.decorators import dag, task
import requests
import pandas as pd
from pandas import json_normalize
from pandas import DataFrame
from sqlalchemy import create_engine


default_args = {
    'start_date': days_ago(1)
}
NY_API = "https://health.data.ny.gov/resource/xdss-u53e.json?$limit=50000&$order=:id"
dbURI = PostgresHook(postgres_conn_id='postgres_new').get_uri()

nycounties = ['Albany', 'Allegany', 'Bronx', 'Broome', 'Cattaraugus', 'Cayuga', 'Chautauqua', 'Chemung', 'Chenango',
              'Clinton', 'Columbia', 'Cortland', 'Delaware', 'Dutchess', 'Erie', 'Essex', 'Franklin', 'Fulton',
              'Genesee', 'Greene', 'Hamilton', 'Herkimer', 'Jefferson', 'Kings', 'Lewis', 'Livingston', 'Madison',
              'Monroe', 'Montgomery', 'Nassau', 'New York', 'Niagara', 'Oneida', 'Onondaga', 'Ontario', 'Orange',
              'Orleans', 'Oswego', 'Otsego', 'Putnam', 'Queens', 'Rensselaer', 'Richmond', 'Rockland', 'Saratoga',
              'Schenectady', 'Schoharie', 'Schuyler', 'Seneca', 'St. Lawrence', 'Steuben', 'Suffolk', 'Sullivan',
              'Tioga', 'Tompkins', 'Ulster', 'Warren', 'Washington', 'Wayne', 'Westchester', 'Wyoming', 'Yates']
totalcounties = 0

with DAG('NY_COVID_INITIAL_LD', schedule_interval='@once', default_args=default_args, catchup=False, template_searchpath='/opt/airflow/') as dag:

    with TaskGroup('INIT_DB_DDL') as processing_group:
        for county in nycounties:
            totalcounties=totalcounties+1
            county = county.replace(" ", "")
            county = county.replace(".", "")
            PostgresOperator(task_id='init_covid_table_'+str(totalcounties),postgres_conn_id='postgres_new',sql="sql/covid_init.sql",params={'countyname': county},database="userdata")

    createFunction = PostgresOperator(task_id='CREATE_FUNCTION',postgres_conn_id='postgres_new',sql="sql/create_trigger.sql",database="userdata")

    @dag.task
    def get_ny_covid_data_full():
        json_data=""
        result = requests.get(NY_API)
        if result.status_code == 200:
            print("Call to api successful")
            print(result.headers)
            json_data = result.json()
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
        "cumulative_number_of_positives": "cummpositives", "total_number_of_tests": "totaltests",
        "cumulative_number_of_tests": "cummtests"}, inplace=True)
        dataframe.to_sql("nymaster", engine, index=False, if_exists='append')

    ##Example of clubbing both extract and load in one task
    # @dag.task
    # def getnycovidhistory_load():
    #     result = requests.get("https://health.data.ny.gov/resource/xdss-u53e.json?$limit=50000&$order=:id")
    #     if result.status_code == 200:
    #         print("Call to api successful")
    #         print(result.text)
    #         print(result.headers)
    #         json_data = result.json()
    #         dataframe: DataFrame = json_normalize(json_data)
    #         print(dataframe.head(2))
    #         engine = create_engine('postgresql://airflow:airflow@postgres:5432/userdata')
    #         dataframe['loaddate'] = pd.to_datetime('today')
    #         dataframe.rename(columns={"test_date": "testdate", "new_positives": "newpositives",
    #         "cumulative_number_of_positives": "cummpositives", "total_number_of_tests": "totaltests",
    #         "cumulative_number_of_tests": "cummtests"}, inplace=True)
    #         dataframe.to_sql("nymaster", engine, index=False, if_exists='append')
    #     else:
    #         print("Error in Api Call")

    # getandloaddata = getnycovidhistory_load()
    
    getdata = get_ny_covid_data_full()
    loadtodb = loaddata(getdata)

processing_group >> createFunction >> getdata >> loadtodb
#Dependency when extract and load is set in one task
#extracting >> processing_group >> loading >> createFunction >> getandloaddata
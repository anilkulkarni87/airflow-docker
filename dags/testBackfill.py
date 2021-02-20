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
from airflow.operators.bash import BashOperator

local_tz = pendulum.timezone("US/Pacific")

default_args = {
    'owner': 'Anil',
    'start_date': datetime(2021, 2, 10, tzinfo=local_tz),
    'schedule_interval': '0 9 * * *',
    'email': 'alert.email@gmail.com'
}

dag = DAG(
    dag_id='TEST_BACKFILL_DAG',
    default_args=default_args,
    catchup=True
)

run_this = BashOperator(
    task_id='also_run_this',
    bash_command='echo "run_id={{ run_id }} | dag_run={{ dag_run }} | ds={{ ds }}"',
    depends_on_past=True,
    dag=dag)

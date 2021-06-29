from operators.treasuredata_operator import treasureDataOperator
from airflow import DAG
from datetime import datetime, timedelta

DEFAULT_ARGS = {
    'owner': 'Airflow',
    'depends_on_past': False,
    'start_date': datetime(2021, 6, 29),
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'catchup': False
}

dag = DAG('TEST_TD_OPERATOR', default_args=DEFAULT_ARGS,
          schedule_interval="@once")

with dag:
    create_table_task = treasureDataOperator(task_id="td-create-table-task",
                                             tdapi="",
                                             tdaccount="",
                                             database="test_db",
                                             table="test_table")

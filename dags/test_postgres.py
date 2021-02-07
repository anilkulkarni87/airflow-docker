from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'Anil',
    'dag_id': 'PostgreOperatorTest_Dag',
    'start_date': days_ago(1),
    'schedule_interval': '@daily'
}

dag: DAG = DAG(
    dag_id='PostgreOperatorTest_Dag',
    default_args=default_args,
    template_searchpath='/opt/airflow/'
)

task1 = PostgresOperator(
    task_id="create_table",
    postgres_conn_id='postgres_new',
    sql="sql/create_table.sql",
    params={'table_name': 'covid'},
    database="userdata",
    dag=dag
)
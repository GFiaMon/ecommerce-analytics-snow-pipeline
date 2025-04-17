from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.bash import BashOperator

PROFILE_DIR = "" # Path to you .dbt we created on the DBT lesson
PROJECT_DIR = "" # Path to your DBT project directory
VENV = "" # Path to activate your venv that contains dbt


default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'dbt_pipeline',
    default_args=default_args,
    description='',
    schedule_interval=None, # "*/5 * * * *" every 5 minutes
    start_date=datetime(2024, 7, 17),
    catchup=False,
)


prep_task = BashOperator(
    task_id='run_prep',
    bash_command=f"source {VENV} && dbt build --profiles-dir {PROFILE_DIR} --project-dir {PROJECT_DIR}",
    dag=dag,
)

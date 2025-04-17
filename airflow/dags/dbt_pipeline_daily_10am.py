from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
import pendulum  # A library for timezone handling

# Set the timezone for Germany (CET/CEST)
local_tz = pendulum.timezone("Europe/Berlin")

PROFILE_DIR = "" # Path to you .dbt we created on the DBT lesson
PROJECT_DIR = "" # Path to your DBT project directory
VENV = "" # Path to activate your venv that contains dbt


default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': pendulum.duration(minutes=5),  # Timezone-aware delay
}

dag = DAG(
    'dbt_pipeline_daily_10am',  # Unique DAG ID
    default_args=default_args,
    description='Runs daily at 10 AM German time',
        schedule_interval='0 10 * * *',  # 10 AM daily in Europe/Berlin time
    start_date=datetime(2024, 7, 17, tzinfo=local_tz),  # Timezone-aware start date
    catchup=False,
    tags=['daily'],
)


prep_task = BashOperator(
    task_id='run_prep',
    bash_command=f"source {VENV} && dbt build --profiles-dir {PROFILE_DIR} --project-dir {PROJECT_DIR}",
    dag=dag,
)

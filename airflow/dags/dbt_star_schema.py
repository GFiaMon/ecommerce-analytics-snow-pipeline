from datetime import timedelta, datetime
from airflow import DAG
from airflow.operators.bash import BashOperator

PROFILE_DIR = ""
PROJECT_DIR = ""
VENV = ""

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the new DAG
dag = DAG(
    'dbt_star_schema',  # Unique DAG ID
    default_args=default_args,
    description='Run only star schema models',
    schedule_interval=None,  # Manual trigger (or set a schedule)
    start_date=datetime(2024, 7, 17),
    catchup=False,
)

# Task to run star schema models
run_star_schema = BashOperator(
    task_id='run_star_schema',
    bash_command=f"""
      source {VENV} && 
      dbt run \
        --select tag:star_schema \
        --profiles-dir {PROFILE_DIR} \
        --project-dir {PROJECT_DIR}
    """,
    dag=dag,
)

# Add more tasks here if needed (e.g., data validation)
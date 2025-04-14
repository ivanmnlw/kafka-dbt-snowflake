from datetime import datetime 
from datetime import timedelta
from pathlib import Path

from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from dbt_airflow.core.config import DbtAirflowConfig
from dbt_airflow.core.config import DbtProfileConfig
from dbt_airflow.core.config import DbtProjectConfig
from dbt_airflow.core.task_group import DbtTaskGroup
from dbt_airflow.operators.execution import ExecutionOperator


with DAG(
    dag_id='test_dag_without_extras',
    catchup=False,
    tags=['example'],
    default_args={
        'owner': 'airflow',
        'retries': 1,
        'retry_delay': timedelta(minutes=2),
    },
    
) as dag:

    t1 = EmptyOperator(task_id='start_task')
    t2 = EmptyOperator(task_id='end_task')

    tg = DbtTaskGroup(
        group_id='transform',
        dbt_project_config=DbtProjectConfig(
            project_path=Path('/data_pipeline_s3/'),
            manifest_path=Path('/data_pipeline_s3/target/manifest.json'),
        ),
        dbt_profile_config=DbtProfileConfig(
            profiles_path=Path('/data_pipeline_s3/'),
            target='dev',
        ),
        dbt_airflow_config=DbtAirflowConfig(
            execution_operator=ExecutionOperator.BASH,
        ),
    )

    t1 >> tg >> t2
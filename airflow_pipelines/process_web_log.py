# import the libraries
from datetime import timedelta
import pathlib 
from pathlib import Path
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators; you need this to write tasks!
from airflow.operators.bash import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'theiadocker-otbonaventur',
    'start_date': days_ago(0),
    'email': ['theia@theiadocker-otbonaventur.net'],
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

# defining the DAG

# define the DAG
dag = DAG(
    'process_web_log',
    default_args=default_args,
    description='''pipeline that analyzes the web server log file,
                 extracts the required lines and fields, 
                 transforms and load to an existing file.''',
    schedule_interval=timedelta(days=1),
)

# define the tasks
capstone_dir = Path('/home/project/airflow/dags/capstone/')
output_dir = "/home/project/airflow"
# define the first task

extract = BashOperator(
    task_id='extract_data',
    bash_command=f'''cut -d" " -f1 {capstone_dir}/accesslog.txt > /tmp/extracted-data.txt''',
    dag=dag,
)

# define the second task
transform = BashOperator(
    task_id='transform_data',
    bash_command=f'''grep "198.46.149.143" /tmp/extracted-data.txt > /tmp/transformed-data.txt''',
    dag=dag,
)

# define the third task
load = BashOperator(
    task_id='load_data',
    bash_command=f'''tar cvzf {output_dir}/weblog.tar.gz /tmp/transformed-data.txt''',
    dag=dag,
)


# task pipeline
extract >> transform >> load
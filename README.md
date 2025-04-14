# Real-Time Data Pipeline Using Kafka, dbt, Snowflake

## Introduction
Real-time taxi app "like" data using fake data. This project build a streaming pipeline from source kafka to sink s3 and load it to snowflake

## Architecture
![architecture](https://github.com/user-attachments/assets/22c098a2-2add-4ba2-9f06-42875bc34026)
Kafka Producer -> Sink to S3 -> Load to Snowflake -> Data Modelling (Fact table and dimension tables) with dbt and load back to snowflake

## Initialization
Docker initialization to build docker image and docker compose
```
make postgres
make kafka
make jupyter
make airflow
```

## Step 1
Connect Kafka with S3 with configuring s3_sink.json file
![s3_sink](https://github.com/user-attachments/assets/f1ab71f7-bc07-4919-9c83-51eaf10c7b14)
After that, open kafka connect container and run this command
```
curl -i -X POST -H "Content-Type: application/json" \
--data @/configs/s3-sink.json \
http://localhost:8083/connectors
```
if status 201, all good to go

## Step 2
Open localhost:9999 jupyter notebook run kafka-producer.ipynb to produce data
Check if the data is loaded into S3 bucket

## Step 3
Run S3-Snowflake-load.sql command in Snowflake project. It will create database and schema and also configure connection between snowflake and S3 using AWS SQS event notification to load data in S3 into Snowflake
![snowflake](https://github.com/user-attachments/assets/003c6407-bfdc-45bb-86c2-30dff59fb95c)

## Step 4
Open localhost:8080 and run airflow dag test_dag_without_extras
![airflow](https://github.com/user-attachments/assets/81344a16-d776-4c01-9f84-c0b3c28d978c)
Data will go to staging area and after that dbt will create fact table and dimension tables

Inspired by : https://medium.com/@murat_aydin/building-a-real-time-streaming-data-pipeline-a-journey-through-apache-kafka-airflow-blob-ece24390eb67






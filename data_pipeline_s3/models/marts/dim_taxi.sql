{{ 
    config(
        materialized='incremental'
        ) 
}}

SELECT DISTINCT
    taxi_id,
    time_of_day
FROM {{ ref('stg_taxi_event') }}
WHERE taxi_id IS NOT NULL

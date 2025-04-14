{{ 
    config(
        materialized='incremental'
        ) 
}}

SELECT DISTINCT
    user_id,
    passenger_current_lat,
    passenger_current_lon,
    passenger_arrival_lat,
    passenger_arrival_lon
FROM {{ ref('stg_taxi_event') }}
WHERE user_id IS NOT NULL

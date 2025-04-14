{{ 
    config(
        materialized='incremental'
        ) 
}}

SELECT DISTINCT
    driver_id,
    drivers_current_lat,
    drivers_current_lon,
    drivers_location,
    drivers_review
FROM {{ ref('stg_taxi_event') }}
WHERE driver_id IS NOT NULL

{{
  config(
    materialized = 'incremental',
    on_schema_change='fail',
    unique='trip_id'
    )
}}

WITH parsed_taxi_event AS (
SELECT
    taxi_event:"trip_id"::STRING AS trip_id,
    taxi_event:"booking_source"::STRING AS booking_source,
    taxi_event:"booking_timestamp"::DATETIME AS booking_timestamp,
    taxi_event:"destination_location"::INTEGER AS destination_location,
    taxi_event:"driver_id"::INTEGER AS driver_id,
    taxi_event:"drivers_current_lat"::FLOAT AS drivers_current_lat,
    taxi_event:"drivers_current_lon"::FLOAT AS drivers_current_lon,
    taxi_event:"drivers_location"::INTEGER AS drivers_location,
    taxi_event:"drivers_review"::INTEGER AS drivers_review,
    taxi_event:"estimated_arrival_time_in_m"::INTEGER AS estimated_arrival_time_in_m,
    taxi_event:"estimated_fare"::INTEGER AS estimated_fare,
    taxi_event:"number_of_passenger"::INTEGER AS number_of_passenger,
    taxi_event:"order_completion_time"::DATETIME AS order_completion_time,
    taxi_event:"passenger_arrival_lat"::FLOAT AS passenger_arrival_lat,
    taxi_event:"passenger_arrival_lon"::FLOAT AS passenger_arrival_lon,
    taxi_event:"passenger_current_lat"::FLOAT AS passenger_current_lat,
    taxi_event:"passenger_current_lon"::FLOAT AS passenger_current_lon,
    taxi_event:"passenger_pick_up_time"::DATETIME AS passenger_pick_up_time,
    taxi_event:"pickup_location"::INTEGER AS pickup_location,
    taxi_event:"status"::STRING AS status,
    taxi_event:"taxi_id"::INTEGER AS taxi_id,
    taxi_event:"time_of_day"::STRING AS time_of_day,
    taxi_event:"traffic_condition"::STRING AS traffic_condition,
    taxi_event:"trip_distance"::FLOAT AS trip_distance,
    taxi_event:"trip_duration"::FLOAT AS trip_duration,
    taxi_event:"trip_rating"::INTEGER AS trip_rating,
    taxi_event:"user_id"::STRING AS user_id,
    taxi_event:"weather_condition"::STRING AS weather_condition,
    DT_INGESTION_TIMESTAMP
FROM {{ source('taxi_event_sources', 'taxi_event') }}
)

SELECT * 
FROM parsed_taxi_event
WHERE 1=1
{% if is_incremental() %}
  AND DT_INGESTION_TIMESTAMP > (select max(DT_INGESTION_TIMESTAMP) from {{ this }})
{% endif %}
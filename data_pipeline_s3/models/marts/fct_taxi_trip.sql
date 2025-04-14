{{ 
    config(
        materialized='incremental', 
        unique_key='trip_id'
        ) 
}}

SELECT
    trip_id,
    user_id,
    driver_id,
    taxi_id,
    pickup_location,
    destination_location,
    booking_timestamp,
    passenger_pick_up_time,
    order_completion_time,
    estimated_arrival_time_in_m,
    trip_distance,
    trip_duration,
    estimated_fare,
    trip_rating,
    number_of_passenger,
    status,
    traffic_condition,
    weather_condition
FROM {{ ref('stg_taxi_event') }}

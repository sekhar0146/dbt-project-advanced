{{ config(materialized='ephemeral') }}

SELECT
    trip_id,
    UPPER(subscriber_type) AS subscriber_type,
    bike_id,
    bike_type,
    start_time,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    COALESCE(duration_minutes, 0) AS duration_minutes
FROM {{ ref('stg_bikeshare_trips') }}
WHERE trip_id IS NOT NULL
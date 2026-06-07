{{ config(
    materialized='incremental'
) }}

SELECT
    trip_id,
    subscriber_type,
    bike_id,
    bike_type,
    start_time,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    duration_minutes
FROM {{ ref('stg_bikeshare_trips') }}

{% if is_incremental() %}
    WHERE start_time >= (SELECT MAX(start_time) FROM {{ this }})
{% endif %}
WITH source AS (
    SELECT *
    FROM {{ source('bigquery_public', 'bikeshare_trips') }}
    LIMIT 1000
)

SELECT
    trip_id,
    COALESCE(subscriber_type, 'Unknown') AS subscriber_type,
    bike_id,
    bike_type,
    start_time,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    duration_minutes
FROM source
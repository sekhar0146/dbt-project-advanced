{{ config(materialized='table') }}

SELECT
    subscriber_type,
    COUNT(*) as trip_count,
    AVG(duration_minutes) as avg_duration
FROM {{ ref('stg_bikeshare_clean') }}
GROUP BY 1
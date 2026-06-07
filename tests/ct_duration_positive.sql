-- This test fails if any duration_minutes <= 0
SELECT
    trip_id,
    duration_minutes
FROM {{ ref('fct_bikeshare_trips_merge') }}
WHERE duration_minutes <= 0
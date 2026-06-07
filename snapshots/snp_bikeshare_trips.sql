{% snapshot snp_bikeshare_trips %}

{{ config(
    target_schema='dbt_advanced',
    unique_key='trip_id',
    strategy='check',
    check_cols=['subscriber_type']
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

{% endsnapshot %}

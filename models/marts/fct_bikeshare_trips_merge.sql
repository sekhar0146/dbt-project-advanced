{{ config(
    materialized='incremental',
    unique_key='trip_id',
    incremental_strategy='merge',
    on_schema_change='append_new_columns',
    post_hook=[
        """
        INSERT INTO `gcp-learnings-498010.dbt_advanced.audit_log`
        (model_name, rows_affected, run_at)
        VALUES (
            '{{ this.name }}',
            (SELECT COUNT(*) FROM {{ this }}),
            CURRENT_TIMESTAMP()
        )
        """
    ]
) }}

SELECT
    t.trip_id,
    t.subscriber_type,
    t.bike_id,
    t.bike_type,
    b.bike_type_description,
    b.is_electric,
    t.start_time,
    t.start_station_id,
    t.start_station_name,
    t.end_station_id,
    t.end_station_name
    {# {{ clean_duration('t.duration_minutes') }} AS duration_minutes #}
FROM {{ ref('stg_bikeshare_trips') }} t
LEFT JOIN {{ ref('bike_type_lookup') }} b
    ON t.bike_type = b.bike_type

{% if is_incremental() %}
    WHERE t.start_time >= (SELECT MAX(start_time) FROM {{ this }})
{% endif %}
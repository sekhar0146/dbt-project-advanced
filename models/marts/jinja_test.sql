{% set subscriber_types = ['Annual Member', 'Single Trip', 'Explorer'] %}

SELECT
    subscriber_type,
    COUNT(*) as trip_count,
    {{safe_divide('SUM(duration_minutes)', 'COUNT(*)')}} AS avg_duration_minutes
FROM {{ ref('stg_bikeshare_trips') }}
WHERE subscriber_type IN (
    {% for sub_type in subscriber_types %}
        '{{ sub_type }}'
        {% if not loop.last %} , {% endif %}
    {% endfor %}
)
GROUP BY 1

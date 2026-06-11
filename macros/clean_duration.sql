{% macro clean_duration(column_name) %}
    CASE
        WHEN {{ column_name }} < 0 THEN 0
        WHEN {{ column_name }} IS NULL THEN 0
        ELSE {{ column_name }}
    END
{% endmacro %}
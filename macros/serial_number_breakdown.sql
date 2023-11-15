{% macro serial_build_date(serial_number) %}
    CASE
        WHEN LENGTH({{ serial_number }}) = 13 AND
        {{ serial_number }} ~ '^\d+$' AND
            CAST(SUBSTRING({{ serial_number }}, 2, 2) AS INT) <= 12 THEN
                TO_DATE(SUBSTRING({{ serial_number }}, 1, 4),'YYMM')
        ELSE NULL
    END
{% endmacro %}

{% macro serial_age(serial_number, date) %}
    CASE
        WHEN serial_number IS NOT NULL THEN
            EXTRACT(YEAR FROM date) - EXTRACT(YEAR FROM serial_build_date(serial_number))
        ELSE NULL
    END
{% endmacro %}
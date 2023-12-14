{% macro is_valid_serial_number(serial_number) %}
    CASE
        WHEN LENGTH({{ serial_number }}) = 13 AND {{ serial_number }} ~ '^\d+$' AND CAST(SUBSTRING({{ serial_number }}, 3, 2) AS INT) <= 12 THEN True
        WHEN LENGTH({{ serial_number }}) = 8 AND {{ serial_number }} ~ '^\d+$' AND CAST(SUBSTRING({{ serial_number }}, 3, 2) AS INT) <= 12 THEN True
        ELSE False
    END 
{% endmacro %}


{% macro serial_build_date(serial_number) %}
    CASE
        WHEN {{ is_valid_serial_number(serial_number) }} = True THEN
            TO_DATE(SUBSTRING({{ serial_number }}, 1, 4),'YYMM')
        ELSE NULL
    END
{% endmacro %}

{% macro serial_build_site(serial_number) %}
    CASE
        WHEN {{ is_valid_serial_number(serial_number) }} = True THEN
            SUBSTRING({{ serial_number }}, 5, 4)
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
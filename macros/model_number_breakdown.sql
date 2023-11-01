{% macro validate_model_number(model_number) %}
    {%- if model_number|length == 16 and model_number|regex_match('^[0-9]+$') -%}
        True
    {%- else -%}
        False
    {%- endif -%}
{%- endmacro %}

{% macro extract_model_range(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' THEN
            LEFT({{ model_number }}, 2)
        ELSE NULL
    END
{% endmacro %}

{% macro extract_model_variant(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             SUBSTRING({{ model_number }}, 3, 1) IN ('A', 'B', 'C', 'D', 'N', 'P', 'S') THEN
            CASE SUBSTRING({{ model_number }}, 3, 1)
                WHEN 'A' THEN 'Stand Alone (US)'
                WHEN 'B' THEN 'Base'
                WHEN 'C' THEN 'Catalytic Convertor'
                WHEN 'D' THEN 'Dependant'
                WHEN 'N' THEN 'Non Cat'
                WHEN 'P' THEN 'Parent'
                WHEN 'S' THEN 'S Edition'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_convection_wattage(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             SUBSTRING({{ model_number }}, 4, 1) IN ('G', 'F', 'E', 'D', 'X', 'S', 'J', 'R') THEN
            CASE SUBSTRING({{ model_number }}, 4, 1)
                WHEN 'G' THEN '900W'
                WHEN 'F' THEN '1300W'
                WHEN 'E' THEN '1500W'
                WHEN 'D' THEN '2200W'
                WHEN 'X' THEN '3000W'
                WHEN 'S' THEN '3200W'
                WHEN 'J' THEN '2000W/900W'
                WHEN 'R' THEN '3600W'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_microwave_wattage(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             SUBSTRING({{ model_number }}, 5, 1) IN ('E', 'X', 'W', 'V', 'T', 'B', 'H', 'O') THEN
            CASE SUBSTRING({{ model_number }}, 5, 1)
                WHEN 'E' THEN '700W'
                WHEN 'X' THEN '1000W'
                WHEN 'W' THEN '1400W'
                WHEN 'V' THEN '1500W'
                WHEN 'T' THEN '1800W'
                WHEN 'B' THEN '2000W'
                WHEN 'H' THEN '800W'
                WHEN 'O' THEN '0W'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}

{% macro extract_hertz(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             SUBSTRING({{ model_number }}, 8, 1) IN ('5', '6') THEN
            CASE SUBSTRING({{ model_number }}, 8, 1)
                WHEN '5' THEN '50Hz'
                WHEN '6' THEN '1000W'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_voltage(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             LENGTH({{ model_number }}) >= 7 THEN
            CASE RIGHT(LEFT({{ model_number }}, 7), 2)
                WHEN '00' THEN '200V'
                WHEN '30' THEN '230V'
                WHEN '20' THEN '220V'
                WHEN '80' THEN '380V'
                WHEN 'MV' THEN 'Multi Voltage'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_plug_type(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             LENGTH({{ model_number }}) >= 10 THEN
            CASE RIGHT(LEFT({{ model_number }}, 10), 1)
                WHEN 'A' THEN 'UK 3-PIN Moulded 13A'
                WHEN 'B' THEN 'EU 2-PIN Shuko Moulded 16A'
                WHEN 'C' THEN 'RED UK 5-PIN (Straight) 32A/Phase'
                WHEN 'D' THEN 'RED EU 5-PIN (R/Angle) 16A/P'
                WHEN 'E' THEN '3-PIN (BLUE) 32A COMMANDO'
                WHEN 'F' THEN 'Moulded NEMA 6-30P 30A'
                WHEN 'G' THEN '(e5) Hubbell 50A'
                WHEN 'H' THEN 'HBL2621 Twist Lock 30A'
                WHEN 'J' THEN '2P+E 32A 200-250V (top taylor)'
                WHEN 'K' THEN 'Australia 5-PIN 2/Phase (Orange) 20A'
                WHEN 'M' THEN 'AZ 3-PIN 1/Phase (Orange) 32A'
                WHEN 'N' THEN 'HBL5466C Straight Blade NEMA 6-20P 20A'
                WHEN 'P' THEN 'HBL4570C Twist Lock NEMA 6-15P 15A'
                WHEN 'R' THEN 'EU 5-PIN (Straight) 16A/Phase'
                WHEN 'S' THEN '2 Pin 15A Korean Approved Plug Type'
                WHEN 'T' THEN 'Australia 3 PIN 1/Phase 15A Orange'
                WHEN 'V' THEN 'Chinese Domestic'
                WHEN 'W' THEN 'Marechal 50A DS3'
                WHEN 'X' THEN 'HBL5666C Straight Blade NEMA 6-15P 15A'
                WHEN 'Y' THEN 'NO PLUG FITTED'
                WHEN 'Z' THEN 'NO PLUG FITTED'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_comms_type(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             LENGTH({{ model_number }}) >= 12 THEN
            CASE RIGHT(LEFT({{ model_number }}, 12), 2)
                WHEN 'U1' THEN 'USB Rev. 1'
                WHEN 'U2' THEN 'USB Rev. 2'
                WHEN 'L1' THEN 'USB+LAN Rev. 1'
                WHEN 'L2' THEN 'USB+LAN Rev. 2'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}

{% macro extract_model_customer(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' AND
             LENGTH({{ model_number }}) >= 14 THEN
            CASE RIGHT(LEFT({{ model_number }}, 14), 2)
                WHEN 'GM' THEN 'General'
                WHEN 'XX' THEN 'Generic'
                WHEN 'SW' THEN 'Subway'
                WHEN 'TH' THEN 'Tim Horton'
                WHEN 'SB' THEN 'Starbucks'
                WHEN 'BA' THEN 'Bako'
                WHEN 'P3' THEN 'PACK 3'
                WHEN 'IA' THEN 'IAWS'
                WHEN 'RS' THEN 'Rolling Stock'
                WHEN 'ES' THEN 'Esso'
                WHEN 'SE' THEN '7-Eleven'
                WHEN 'GJ' THEN 'Gloria Jeans'
                WHEN 'CD' THEN 'Coffee Day'
                WHEN 'AA' THEN 'e2 Race Track'
                WHEN 'AB' THEN 'e2 Brueggers'
                WHEN 'AC' THEN 'e2 Einsteins'
                WHEN 'AD' THEN 'e6 Circle K'
                WHEN 'AE' THEN 'e6 Winn Dixie'
                WHEN 'AF' THEN 'e6 Cumberland Farms'
                WHEN 'AG' THEN 'e6 Thorntons'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


{% macro extract_model_country(model_number) %}
    CASE
        WHEN LENGTH({{ model_number }}) = 16 AND
             LEFT({{ model_number }}, 1) ~ '^[A-Za-z]' THEN
            CASE RIGHT({{ model_number }}, 2)
                WHEN 'AP' THEN 'Asia Pacific'
                WHEN 'AZ' THEN 'Australia'
                WHEN 'BO' THEN 'Bolivia'
                WHEN 'BR' THEN 'Brazil'
                WHEN 'CA' THEN 'Canada'
                WHEN 'CN' THEN 'China'
                WHEN 'EU' THEN 'Europe'
                WHEN 'DE' THEN 'Germany'
                WHEN 'IN' THEN 'India'
                WHEN 'ID' THEN 'Indonesia'
                WHEN 'JP' THEN 'Japan'
                WHEN 'LA' THEN 'Latin America'
                WHEN 'MR' THEN 'Marine Spec'
                WHEN 'MX' THEN 'Mexico'
                WHEN 'PH' THEN 'Philippines'
                WHEN 'PL' THEN 'Poland'
                WHEN 'RU' THEN 'Russia'
                WHEN 'SA' THEN 'Saudi Arabia'
                WHEN 'KR' THEN 'South Korea'
                WHEN 'TW' THEN 'Taiwan'
                WHEN 'VN' THEN 'Vietnam'
                WHEN 'UK' THEN 'UK'
                WHEN 'US' THEN 'USA'
                ELSE NULL
            END
        ELSE NULL
    END
{% endmacro %}


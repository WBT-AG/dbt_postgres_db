{% macro validate_model_number(model_number) %}
    {%- if model_number|length == 16 and model_number|regex_match('^[0-9]+$') -%}
        Valid Model Number
    {%- else -%}
        Invalid Model Number
    {%- endif -%}
{%- endmacro %}


-- GET MODEL VARIANT FROM MODEL NUMBER
{% macro get_model_variant(model_number) %}
    {%- set variant_mapping = {
        'e3': 'Variant 1',
        'e2': 'Variant 2',
        'e3': 'Variant 3',
        'e4': 'Variant 4',
        'e5': 'Variant 5',
        'e6': 'Variant 6',
        'e1': 'Variant 7'
    } -%}

    {%- set variant_prefix = model_number[:2] -%}

    {%- if variant_prefix in variant_mapping -%}
        {{ variant_mapping[variant_prefix] }}
    {%- else -%}
        Unknown Variant
    {%- endif -%}
{%- endmacro %}

-- models/your_model_name.sql

WITH claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),

Final AS (
    SELECT 
        c.*,
        CASE
            WHEN LENGTH(c.serial_number_cleaned) = 13 THEN 
                TO_DATE(
                    SUBSTRING(c.serial_number_cleaned, 1, 4),
                    'YYMM'
                ) + INTERVAL '1 day'
            ELSE NULL
        END AS asset_build_date,
        CASE
            WHEN LENGTH(c.serial_number_cleaned) = 13 THEN
                SUBSTRING(c.serial_number_cleaned, 5, 4)
            ELSE NULL
        END AS asset_build_location,
        {{ extract_model_range('model_number') }} AS model_range,
        {{ extract_model_variant('model_number') }} AS model_variant,
        {{ extract_convection_wattage('model_number') }} AS convection_wattage,
        {{ extract_microwave_wattage('model_number') }} AS microwave_wattage,
        {{ extract_voltage('model_number') }} AS voltage,
        {{ extract_hertz('model_number') }} AS hertz,
        {{ extract_plug_type('model_number') }} AS plug_type,
        {{ extract_comms_type('model_number') }} AS comms_type,
        {{ extract_model_customer('model_number') }} AS model_customer,
        {{ extract_model_country('model_number') }} AS model_country
    FROM claims c
)

SELECT
    *,
    CASE
        WHEN asset_build_date IS NOT NULL THEN
            EXTRACT(YEAR FROM "created_date") - EXTRACT(YEAR FROM asset_build_date)
        ELSE NULL
    END AS asset_age_in_years
FROM Final

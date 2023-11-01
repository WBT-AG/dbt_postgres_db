-- models/your_model_name.sql

WITH claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),
warranty_registrations AS (
    SELECT
        registration_id,
        CAST(upper(model_number) AS VARCHAR(16)) AS model_number
    FROM {{ ref('stg_salesforce__warranty_registrations') }}
),
Final AS (
    SELECT 
        c.*,
        wr.model_number,
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
        {{ extract_model_range('wr.model_number') }} AS model_range,
        {{ extract_model_variant('wr.model_number') }} AS model_variant,
        {{ extract_convection_wattage('wr.model_number') }} AS convection_wattage,
        {{ extract_microwave_wattage('wr.model_number') }} AS microwave_wattage,
        {{ extract_voltage('wr.model_number') }} AS voltage,
        {{ extract_hertz('wr.model_number') }} AS hertz,
        {{ extract_plug_type('wr.model_number') }} AS plug_type,
        {{ extract_comms_type('wr.model_number') }} AS comms_type,
        {{ extract_model_customer('wr.model_number') }} AS model_customer,
        {{ extract_model_country('wr.model_number') }} AS model_country
    FROM claims c
    LEFT JOIN warranty_registrations wr ON c.warranty_registration = wr.registration_id
)
SELECT
    *,
    CASE
        WHEN asset_build_date IS NOT NULL THEN
            EXTRACT(YEAR FROM "created_date") - EXTRACT(YEAR FROM asset_build_date)
        ELSE NULL
    END AS asset_age_in_years
FROM Final

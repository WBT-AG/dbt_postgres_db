WITH claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),
warranty_registrations AS (
    SELECT
        registration_id,
        model_number
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
        END AS asset_build_location
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

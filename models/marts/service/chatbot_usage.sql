WITH chat_sessions AS (
    SELECT * FROM {{ ref('stg_tech_assist__chat_sessions') }}
),
Final AS (
    SELECT 
        *,
        CASE
            WHEN LENGTH(serial_number_cleaned) = 13 THEN 
                TO_DATE(
                    SUBSTRING(serial_number_cleaned, 1, 4),
                    'YYMM'
                ) + INTERVAL '1 day'
            ELSE NULL
        END AS asset_build_date,
        CASE
            WHEN LENGTH(serial_number_cleaned) = 13 THEN
                SUBSTRING(serial_number_cleaned, 5, 4)
            ELSE NULL
        END AS asset_build_location
    FROM chat_sessions
)
SELECT
    *,
    CASE
        WHEN asset_build_date IS NOT NULL THEN
            EXTRACT(YEAR FROM "date") - EXTRACT(YEAR FROM asset_build_date)
        ELSE NULL
    END AS asset_age_in_years
FROM Final

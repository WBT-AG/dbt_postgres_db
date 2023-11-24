-- Import Salesforce CPS Claims
WITH cps_claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),

-- Import Salesforce CPS Registrations. Required to pull the model numbers.
cps_registrations AS (
    SELECT
        registration_id,
        CAST(upper(model_number) AS VARCHAR(16)) AS model_number
    FROM {{ ref('stg_salesforce__warranty_registrations') }}
),

-- Merge CPS Claims and CPS Model Numbers
cps_claims_full AS (
    SELECT
        CAST(cc.claim_id AS TEXT) as id,
        'Salesforce' as system,
        cc.claim_status as status,
        cc.created_date as submission_date,
        cc.country,
        cc.state_province,
        cc.city,
        cr.model_number,
        cc.serial_number_cleaned as serial_number,
        cc.service_incident_summary,
        cc.repair_completion_date as repair_date
    FROM cps_claims cc
    LEFT JOIN cps_registrations cr ON cc.warranty_registration = cr.registration_id
),

-- Import Tesseract Service Calls
tesseract_calls AS (
    SELECT
        call_number as id,
        'Tesseract' as system,
        status,
        r_date as submission_date,
        country_code as country,
        site_county as state_province,
        site_town as city,
        model_number,
        serial_number
    FROM {{ ref('stg_tesseract__calls') }}
),

-- Import Tesseract Field Service Report details
tesseract_field_reports AS (
    SELECT
        call_number as id,
        complete_date as repair_date,
        model_brand,
        solution as summary
    FROM {{ ref('stg_tesseract__service_reports') }}
),

-- Merge Tesseract data
tesseract_calls_full AS (
    SELECT
        CAST(tc.id AS TEXT) as id,
        tc.system,
        tc.status,
        tc.submission_date,
        tc.country,
        tc.state_province,
        tc.city,
        tc.model_number,
        tc.serial_number,
        tr.summary,
        tr.repair_date
    FROM tesseract_calls tc
    LEFT JOIN tesseract_field_reports tr ON tc.id = tr.id
    WHERE tr.model_brand = 'Merrychef'
),

-- Merge Tesseract & CPS Data
all_issues AS (
    SELECT * FROM cps_claims_full
    UNION ALL
    SELECT * FROM tesseract_calls_full
),

final AS (
    select *,
    {{ extract_model_range('ai.model_number') }} AS model_range,
    {{ extract_model_variant('ai.model_number') }} AS model_variant,
    {{  serial_build_date('ai.serial_number') }} AS model_build_date
    FROM all_issues ai
)

-- Final Select Statement
SELECT * FROM final

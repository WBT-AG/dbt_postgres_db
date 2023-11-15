WITH service_reports AS (
    SELECT * FROM {{ ref('stg_tesseract__service_reports') }}
),
service_lines_summary AS (
    SELECT
        sl.call_number,
        SUM(sl.charge) AS total_charge
    FROM {{ ref('stg_tesseract__service_report_lines') }} sl
    GROUP BY sl.call_number
),
final AS (
    SELECT
        sr.call_number,
        sr.status,
        sr.area_code,
        sr.complete_date,
        sr.model_number,
        {{ extract_model_range('sr.model_number') }} AS model_range,
        {{ extract_model_variant('sr.model_number') }} AS model_variant,
        sr.serial_number,
        {{  serial_build_date('sr.serial_number') }} AS model_build_date,
        sr.solution,
        {{ classify_model_number('sr.model_number') }} AS model_brand,
        -- Add the total_charge column from the service_lines_summary subquery
        sls.total_charge
    FROM service_reports sr
    -- Join the service_lines_summary subquery by call_number
    LEFT JOIN service_lines_summary sls ON sr.call_number = sls.call_number
)

SELECT * FROM final

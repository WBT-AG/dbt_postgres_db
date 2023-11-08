WITH service_reports as (
    SELECT * FROM {{ ref('stg_tesseract__service_reports') }}
),
final as (
    select
    sr.call_number,
    sr.status,
    sr.area_code,
    sr.complete_date,
    sr.model_number
    from service_reports sr
)

SELECT * FROM Final
WITH service_line_items AS (
    SELECT * FROM {{ ref('stg_tesseract__service_report_lines') }}
),

service_parts AS (
    SELECT
        sli.call_number,
        sli.part_number,
        sli.part_description,
        sli.quantity,
        sli.cost,
        sli.charge,
        cast(sli.invoice_date AS DATE)
    FROM service_line_items sli
),

final AS (
    SELECT * 
    FROM service_parts sp
    ORDER BY sp.call_number
)

SELECT * FROM final
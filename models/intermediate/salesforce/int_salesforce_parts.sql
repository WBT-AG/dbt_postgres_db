WITH service_lines AS (
    SELECT * FROM {{ ref('stg_salesforce__service_lines') }}
),

claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),

parts AS (
    SELECT * FROM {{ ref('stg_salesforce__parts') }}
),

final AS (
    SELECT
        c.claim_name as claim_id,
        p.name as part_number,
        sl.part_description,
        sl.approved_quantity as quantity,
        sl.approved_rate_charge as charge,
        sl.currency,
        c.invoice_date
    FROM service_lines sl
    JOIN claims c ON sl.claim_id = c.claim_id
    JOIN parts p ON sl.part_number = p.id
    WHERE sl.asset_brand = 'MERRYCHEF'
    AND sl.service_line_type = 'Parts'
    
)

SELECT * FROM final
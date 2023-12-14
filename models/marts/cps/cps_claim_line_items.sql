WITH staging_claim_line_items AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__service_lines') }}
),

final AS (
    SELECT 
        scli.*
    FROM staging_claim_line_items scli
)

SELECT * from final
WITH staging_claim_line_items AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__service_lines') }}
),

staging_claims AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__claims') }}
),

final AS (
    SELECT 
        scli.part_description,
        sc.model_number,
        sc.serial_number,
        sc.service_incident_summary,
        sc.claim_name,
        sc.claim_status,
        sc.claim_type,
        {{  extract_model_range('sc.model_number') }} as range,
        sc.failure_date     
    FROM staging_claim_line_items scli
    LEFT JOIN staging_claims sc ON scli.claim_id = sc.claim_id
    WHERE scli.service_line_type = 'Parts'
)

SELECT * from final
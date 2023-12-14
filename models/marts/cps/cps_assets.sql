WITH staging_assets AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__assets') }}
),

staging_claims AS (
        SELECT 
        *
    FROM {{ ref('stg_salesforce__claims') }}
),

final AS (
    SELECT 
        sa.*,
        sc.model_number
    FROM staging_assets sa
    JOIN staging_claims sc ON sa.serial_number = sc.serial_number
)

SELECT * from final
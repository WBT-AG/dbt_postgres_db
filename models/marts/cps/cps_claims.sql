WITH staging_claims AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__claims') }}
),

final AS (
    SELECT 
        sc.*
    FROM staging_claims sc
)

SELECT * from final
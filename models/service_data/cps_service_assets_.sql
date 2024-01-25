WITH staging_assets AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__assets') }}
),


final AS (
    SELECT 
*
    FROM staging_assets sa
)

SELECT * from final
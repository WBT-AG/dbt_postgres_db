WITH claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),

final AS (
    SELECT * 
    FROM claims
)

SELECT * FROM final
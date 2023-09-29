WITH gocardless_payouts AS (
    SELECT 
        *,
        'gocardless' as source
    FROM {{ ref('stg_gocardless__payouts') }}
)


SELECT * from gocardless_payouts
WITH gocardless_payments AS (
    SELECT 
        *,
        'gocardless' as source
    FROM {{ ref('stg_gocardless__payments') }}
)


SELECT * from gocardless_payments
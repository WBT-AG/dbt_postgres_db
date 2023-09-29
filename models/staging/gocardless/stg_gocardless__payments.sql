WITH airbyte_payments AS (
    SELECT * FROM {{ source('gocardless', 'airbyte_payments')}} 
),

final AS (
    SELECT
        airbyte_payments.status as "status",
        CAST(airbyte_payments.created_at AS DATE) as created_date,
        CAST(airbyte_payments.charge_date AS DATE) as charge_date,
        (CAST(airbyte_payments.amount AS DECIMAL(10, 2)) / 100.0) as amount, -- Divide by 100 for pounds
        airbyte_payments.currency::VARCHAR as currency,
        airbyte_payments.id as id
    FROM airbyte_payments
)


-- Select * from Final CTE
SELECT * FROM final
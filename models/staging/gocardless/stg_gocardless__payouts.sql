WITH airbyte_payouts AS (
    SELECT * FROM {{ source('gocardless', 'airbyte_payouts')}} 
),

final AS (
    SELECT
        airbyte_payouts.status as "status",
        CAST(airbyte_payouts.created_at AS DATE) as created_date,
        CAST(airbyte_payouts.arrival_date AS DATE) as arrival_date,
        (CAST(airbyte_payouts.amount AS DECIMAL(10, 2)) / 100.0) as amount,
        (CAST(airbyte_payouts.deducted_fees AS DECIMAL(10, 2)) / 100.0) as fees,
        airbyte_payouts.currency::VARCHAR as currency,
        airbyte_payouts.id as id
    FROM airbyte_payouts
)


-- Select * from Final CTE
SELECT * FROM final
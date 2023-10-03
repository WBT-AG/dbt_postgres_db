WITH airbyte_electricity_usage AS (
    SELECT * FROM {{ source('resource_advisor', 'airbyte_electricity_usage')}} 
),

final AS (
    SELECT
        CAST(airbyte_electricity_usage."Usage" AS NUMERIC(18, 6)) as usage,
        airbyte_electricity_usage.uomname::VARCHAR as measure,
        CAST(airbyte_electricity_usage."Cost" AS NUMERIC(12, 2)) as cost,
        airbyte_electricity_usage.currencyname::VARCHAR as currency,
        airbyte_electricity_usage.sitename::VARCHAR as site,
        TO_DATE(airbyte_electricity_usage."Month", 'mm/yyyy') as date
    FROM airbyte_electricity_usage
)


-- Select * from Final CTE
SELECT * FROM final
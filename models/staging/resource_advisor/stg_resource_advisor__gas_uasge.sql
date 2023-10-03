WITH airbyte_gas_usage AS (
    SELECT * FROM {{ source('resource_advisor', 'airbyte_gas_usage')}} 
),

final AS (
    SELECT
        CAST(airbyte_gas_usage."Usage" AS NUMERIC(18, 6)) as usage,
        CAST(airbyte_gas_usage.weathernormalizedtotalusage AS NUMERIC(18, 6)) as normalised_usage,
        airbyte_gas_usage.uomname::VARCHAR as measure,
        CAST(airbyte_gas_usage."Cost" AS NUMERIC(12, 2)) as cost,
        airbyte_gas_usage.currencyname::VARCHAR as currency,
        airbyte_gas_usage.sitename::VARCHAR as site,
        TO_DATE(airbyte_gas_usage."Month", 'mm/yyyy') as date
    FROM airbyte_gas_usage
)


-- Select * from Final CTE
SELECT * FROM final
WITH stg_electricity AS (
    SELECT * FROM {{ ref('stg_resource_advisor__electricity_usage') }}
),

stg_gas AS (
    SELECT * FROM {{ ref('stg_resource_advisor__gas_uasge') }}
),

-- Custom Logic: Add your transformations here if needed
Final AS(
    SELECT 
        stg_electricity.date,
        stg_electricity.site as site,
        stg_electricity.usage as electricity_usage,
        stg_electricity.measure as electricity_measure,
        stg_electricity.cost as electircity_cost,
        stg_gas.usage as gas_usage,
        stg_gas.measure as gas_measure,
        stg_gas.cost as gas_cost,
        stg_gas.currency as currency
    FROM stg_electricity
    JOIN stg_gas
    ON stg_electricity.date = stg_gas.date
)

-- Select * from Final CTE
SELECT * FROM Final

WITH drax_airbyte_electricity AS (
    -- Select data from the source
    SELECT
        cast(timestamp as timestamp) as timestamp,
        cast(date as date) as date,
        'half-hour' as half_hour,
        kwh as kwh 
    FROM {{ source('drax', 'airbyte_electricity')}}
)

-- Custom Logic: Add your transformations here if needed

-- Select * from Final CTE
SELECT * FROM drax_airbyte_electricity

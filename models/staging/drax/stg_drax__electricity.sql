WITH drax_airbyte_electricity AS (
    SELECT * FROM {{ source('drax', 'airbyte_electricity')}} 
),

final AS (
    SELECT
        TO_DATE(drax_airbyte_electricity.date, 'dd/mm/yyyy') as date,
        TO_TIMESTAMP(drax_airbyte_electricity.timestamp, 'dd/MM/yyyy HH24:MI:SS') as timestamp,
        drax_airbyte_electricity."half-hour" as half_hour,
        CAST(drax_airbyte_electricity.kwh AS DECIMAL(5, 1)) AS kwh -- Cast kwh to DECIMAL(5, 1)
    FROM drax_airbyte_electricity
)


-- Select * from Final CTE
SELECT * FROM final

WITH stg_electricity AS (
    SELECT * FROM {{ ref('stg_drax__electricity') }}
),

electricity AS (
    -- Select data from the source
    SELECT
        stg_electricity.date as "date",
        stg_electricity.timestamp as timestamp,
        stg_electricity.half_hour as half_hour,
        CAST(kwh AS DECIMAL(5, 1)) AS kwh
    FROM stg_electricity
)

-- Custom Logic: Add your transformations here if needed

-- Select * from Final CTE
SELECT * FROM electricity

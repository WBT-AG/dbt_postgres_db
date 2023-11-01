WITH tesseract_repair_types AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_screp')}} 
),

final AS (
    SELECT
        rt.rep_code as repair_code,
        rt.rep_desc as repair_description,
        cast(rt.rep_last_update as DATE) as last_update
    FROM tesseract_repair_types rt
)

-- Select * from Final CTE
SELECT * FROM final
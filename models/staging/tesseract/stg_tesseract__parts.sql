WITH tesseract_parts AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_scpart')}} 
),

final AS (
    SELECT
        pa.part_alternate_desc_1 as alternate_description,
        pa.part_cost as cost,
        pa.part_country_code as country_code,
        pa.part_desc as description,
        pa.part_num as part_number,
        pa.part_sale_dis as sale_discount,
        pa.part_status as status,
        pa.part_war_unit as warranty_unit
    FROM tesseract_parts pa
)

-- Select * from Final CTE
SELECT * FROM final
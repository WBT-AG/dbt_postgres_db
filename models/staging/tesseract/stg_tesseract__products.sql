WITH tesseract_products AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_scprod')}} 
),

final AS (
    SELECT
        pr.prod_desc as product_description,
        pr.prod_cust_war_billable as customer_warranty_billable,
        pr.prod_country_code as country_code,
        pr.prod_cust_lab_war_qty as customer_labour_warranty_months,
        pr.prod_mmc as mmc,
        pr.prod_type as product_type,
        pr.prod_cust_war_qty as customer_warranty_months,
        pr.prod_memo as memo,
        pr.prod_group as product_group,
        pr.prod_cover_code as cover_code,
        pr.prod_manufac_part_num as manufacturer_part_number,
        pr.prod_prodfamily_code as product_family_code,
        pr.prod_contract_pop as contract_pop,
        pr.prod_lab_war_qty as labour_warranty_quantity,
        pr.prod_installed_pop as installed_pop,
        pr.prod_cost as product_cost,
        pr.prod_war_qty as warranty_quantity,
        pr.prod_num as product_number,
        pr.prod_cust_lab_war_billable as customer_labour_warranty_billable,
        pr.prod_manufac as product_manufacturer,
        pr.prod_cust_lab_war_unit as customer_labour_warranty_unit,
        pr.prod_war_unit as warranty_unit,
        pr.prod_part_num as product_part_number
    FROM tesseract_products pr
)

-- Select * from Final CTE
SELECT * FROM final
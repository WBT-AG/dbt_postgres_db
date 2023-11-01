WITH tesseract_service_line_report_lines AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_scfsrl')}} 
),

final AS (
    SELECT
        srl.fsrl_billable as is_billable,
        srl.fsrl_call_num as call_number,
        srl.fsrl_charge as charge,
        srl.fsrl_cost as cost,
        srl.fsrl_cost_centre as cost_center,
        srl.fsrl_fsr_num as fsr_number,
        srl.fsrl_inv_date as invoice_date,
        srl.fsrl_inv_num as invoice_number,
        srl.fsrl_part_desc as part_description,
        srl.fsrl_part_num as part_number,
        srl.fsrl_qty as quantity,
        srl.fsrl_stock_site_num as stock_site_number
    FROM tesseract_service_line_report_lines srl
)

-- Select * from Final CTE
SELECT * FROM final
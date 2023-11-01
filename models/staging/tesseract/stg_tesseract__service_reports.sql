WITH tesseract_service_reports AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_scfsr')}} 
),

final AS (
    SELECT
        sr.fsr_area_code as area_code,
        sr.fsr_call_num as call_number,
        sr.fsr_call_status as status,
        sr.fsr_callsubstatus_code as call_substatus,
        sr.fsr_complete_date as complete_date,
        sr.fsr_cost_centre as cost_center,
        sr.fsr_disp_date as dispatch_date,
        sr.fsr_employ_num as employee_number,
        sr.fsr_fault_code as fault_code,
        sr.fsr_miles as miles,
        sr.fsr_num as fsr_number,
        sr.fsr_prod_num as product_number,
        sr.fsr_ref_num as referance_number,
        sr.fsr_ref1 as ref1,
        sr.fsr_ref2 as res2,
        sr.fsr_rep_code as repair_code,
        sr.fsr_responsemap_id as responsemap_id,
        sr.fsr_ser_num as serial_number,
        sr.fsr_site_num as site_number,
        sr.fsr_solution as solution,
        sr.fsr_start_date as start_date,
        sr.fsr_symp_code as symp_code,
        sr.fsr_travel_time as trave_time,
        sr.fsr_type_name as type_name,
        sr.fsr_user as user,
        sr.fsr_work_time as work_time
    FROM tesseract_service_reports sr
)

-- Select * from Final CTE
SELECT * FROM final
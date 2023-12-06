WITH tesseract_service_reports AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_scfsr')}} 
),

final AS (
    SELECT
        sr.fsr_area_code as area_code,
        sr.fsr_call_num as call_number,
        sr.fsr_call_status as status,
        sr.fsr_callsubstatus_code as call_substatus,
        TO_DATE(sr.fsr_complete_date, 'YYY-MM-DD') as complete_date,
        sr.fsr_cost_centre as cost_center,
        TO_DATE(sr.fsr_disp_date, 'YYY-MM-DD') as dispatch_date,
        sr.fsr_employ_num as employee_number,
        sr.fsr_fault_code as fault_code,
        sr.fsr_miles as miles,
        sr.fsr_num as fsr_number,
        upper(sr.fsr_prod_num) as model_number,
        sr.fsr_ref_num as referance_number,
        sr.fsr_ref1 as ref1,
        sr.fsr_rep_code as repair_code,
        sr.fsr_ser_num as serial_number,
        sr.fsr_site_num as site_number,
        sr.fsr_solution as solution,
        TO_DATE(sr.fsr_start_date, 'YYY-MM-DD') as start_date,
        sr.fsr_symp_code as symp_code,
        sr.fsr_travel_time as trave_time,
        sr.fsr_type_name as type_name,
        sr.fsr_user as user,
        sr.fsr_work_time as work_time,
        {{ classify_model_number('sr.fsr_prod_num') }} AS model_brand,
        upper({{ extract_model_range('sr.fsr_prod_num') }}) AS model_range,
        {{ serial_build_date('sr.fsr_ser_num') }} AS model_build_date,
        {{ is_valid_serial_number('sr.fsr_ser_num') }} AS has_valid_serial
    FROM tesseract_service_reports sr
)

-- Select * from Final CTE
SELECT * FROM final
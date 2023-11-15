WITH tesseract_calls AS (
    SELECT * FROM {{ source('tesseract', 'airbyte_sccall')}} 
),

final AS (
    SELECT
        ca.call_adate::TIMESTAMPTZ::DATE as a_date,
        ca.call_appointment_date as appointment_date,
        ca.call_area_code as area_code,
        ca.call_callsubstatus_code as substatus_code,
        ca.call_cloned_call_num as cloned_call_number,
        ca.call_contractrdate as contractr_date,
        ca.call_count as call_count,
        ca.call_country_code as country_code,
        ca.call_cust_name as customer_name,
        ca.call_cust_num as customer_number,
        ca.call_ebd_fix as ebd_fix,
        ca.call_ebd_resp as ebd_response,
        ca.call_eta_date as eta_date,
        ca.call_fdate as f_date,
        ca.call_fix_hour as fix_hour,
        ca.call_fsr_count as fsr_count,
        ca.call_last_fsr_num as last_fsr_number,
        ca.call_last_task_num as last_task_number,
        ca.call_num as call_number,
        ca.call_orig_appointment_date as origonal_appointment_date,
        ca.call_prob_code as problem_code,
        ca.call_problem as problem_description,
        ca.call_prod_num as model_number,
        ca.call_prodfamily_code as product_family_code,
        ca.call_rdate as r_date,
        ca.call_ref2 as ref_2,
        ca.call_req_count as req_type,
        ca.call_res_code as reson_code,
        ca.call_resp_offset as resp_offset,
        ca.call_rhold as r_hold,
        ca.call_rtime as rtime,
        ca.call_ser_num as serial_number,
        ca.call_ser_system_num as serial_system_number,
        ca.call_site_area_code as site_area_code,
        ca.call_site_county as site_county,
        ca.call_site_memo as site_memo,
        ca.call_site_name as site_name,
        ca.call_site_post_code as site_post_code,
        ca.call_site_town as site_town,
        ca.call_status as status,
        ca.call_stime as s_time,
        ca.call_supplier_warranty_flag as supplier_warranty,
        ca.call_transaction_id as transaction_id
    FROM tesseract_calls ca
)

-- Select * from Final CTE
SELECT * FROM final
WITH th_rollout AS (
    SELECT * FROM {{ source('google_sheets', 'airbyte_th_rollout')}} 
),

final AS (
    SELECT
        prv,
        s_n as serial_number,
        seq,
        sr_,
        city,
        phase,
        oven_1 as oven_1_model,
        oven_2 as oven_2_model,
        status,
        address,
        oven_qty::int,
        del_notes,
        po_number,
        del_status as delivery_status,
        call_2_date,
        postal_code,
        restaurant_ as restaurant_number,
        TO_DATE(install_date, 'DD/MM/YYYY') as install_date,
        install_week,
        SUBSTRING(install_week FROM 3)::int as install_week_number,
        call_3_status,
        del_timestamp,
        TO_DATE(install_date_2, 'DD/MM/YYYY') as install_date_2,
        install_status,
        responsibility,
        notes_from_call,
        reschedule_date,
        call_3_timestamp,
        month_of_install,
        restaurant_group,
        notes_from_call_2,
        next_step_required,
        call_date_month_prior_,
        call_1_to_owner_month_prior_,
        call_2_to_owner_2_weeks_prior_
    FROM th_rollout
)

-- Select * from Final CTE
SELECT * FROM final

WITH th_tracker_data AS (
    SELECT * FROM {{ source('google_sheets', 'airbyte_th_tracker_data')}} 
),

final AS (
    SELECT
        prv,
        s_n as serial_number,
        sr_,
        city,
        phase,
        oven_1 as oven_1_model,
        oven_2 as oven_2_model,
        address,
        oven_qty::int,
        del_notes,
        del_status as delivery_status,
        postal_code,
        restaurant_ as restaurant_number,
        TO_DATE(install_date, 'DD/MM/YYYY') as install_date,
        install_week,
        SUBSTRING(install_week FROM 3)::int as install_week_number,
        del_timestamp as delivery_timestamp,
        TO_DATE(install_date_2, 'DD/MM/YYYY') as install_date_2,
        install_status,
        responsibility,
        month_of_install,
        next_step_required
    FROM th_tracker_data
)

-- Select * from Final CTE
SELECT * FROM final

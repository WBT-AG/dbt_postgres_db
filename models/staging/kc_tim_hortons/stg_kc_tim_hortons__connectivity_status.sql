WITH connectivity_status AS (
    SELECT * FROM {{ source('kc_tim_hortons', 'airbyte_connectivity_status')}} 
),

final AS (
    SELECT 
        cast(deviceid as VARCHAR(255)) as device_id,
        lastonlinedate as last_online_date,
        lastonlineindays as last_online_days,
        droppedconnection as dropped_connection,
        totaldroppedconnection as total_dropped_connection
    FROM connectivity_status 
)

SELECT * FROM final
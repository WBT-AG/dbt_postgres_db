WITH devices AS (
    SELECT * FROM {{ ref('stg_kc_tim_hortons__devices') }}
),

connectivity AS (
    SELECT * FROM {{ ref('stg_kc_tim_hortons__connectivity_status') }}
),

software AS (
    SELECT * FROM {{ ref('stg_kc_tim_hortons__software_versions') }}
),

Final AS (
    SELECT
        d.device_id as serial_number,
        d.model as model,
        d.locationname as location_code,
        d.locationid as location_id,
        pincode as zip_code,
        c.last_online_date as last_connected_date,
        CASE
            WHEN c.last_online_date <> '' THEN 'Y'
            ELSE 'N'
        END AS has_been_connected,
        d.networktype as network_type,
        s.firmwareversionqts as software_version
    FROM devices d
    JOIN connectivity c ON d.device_id = c.device_id
    JOIN software s ON d.devicehashid = s.devicehashid
)

SELECT * FROM Final

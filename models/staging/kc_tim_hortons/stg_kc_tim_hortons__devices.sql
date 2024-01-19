WITH devices AS (
    SELECT * FROM {{ source('kc_tim_hortons', 'airbyte_devices')}} 
),

final AS (
    SELECT
        path,
        level,
        model,
        nodeid,
        status,
        street,
        country,
        pincode,
        deviceid as device_id,
        brandname,
        productid,
        customerid,
        locationid,
        assetnumber,
        networktype,
        customername,
        locationname,
        locationtype,
        networkstatus,
        networksignallevel,
        _airbyte_airbyte_devices_hashid as devicehashid
    FROM devices
)

-- Select * from Final CTE
SELECT * FROM final
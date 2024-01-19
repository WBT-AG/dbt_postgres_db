WITH softwareversions AS (
    SELECT * FROM {{ source('kc_tim_hortons', 'airbyte_devices_softwareversion')}} 
),

final AS (
    SELECT 
        _airbyte_airbyte_devices_hashid as devicehashid,
        firmwareversioniot,
        firmwareversionqts,
        firmwareversionsrb
    FROM softwareversions
)

SELECT * FROM final
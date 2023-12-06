WITH service_reports AS (
    SELECT * FROM {{ ref('stg_tesseract__service_reports') }}
),

assets AS (
    SELECT
        serial_number,
        model_number
        --upper(asset_location_country) as country
    FROM service_reports sr
    WHERE sr.model_brand = 'Merrychef'

),

asset_details AS (
    SELECT
        *,
        {{  is_valid_serial_number('a.serial_number') }} as has_valid_serial,
        {{  is_valid_model_number('a.model_number') }} as has_valid_model,
        {{  serial_build_date('a.serial_number') }} as build_date,
        {{  serial_build_site('a.serial_number') }} as build_site,
        {{  extract_model_range('a.model_number') }} as range,
        {{  extract_model_variant('a.model_number') }} as variant,
        {{  extract_voltage('a.model_number') }} as voltage
    FROM assets a
),

final AS (
    SELECT * 
    FROM asset_details ad 
    ORDER BY ad.serial_number
)

SELECT * FROM final
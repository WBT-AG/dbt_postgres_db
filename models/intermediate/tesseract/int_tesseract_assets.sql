WITH service_reports AS (
    SELECT * FROM {{ ref('stg_tesseract__service_reports') }}
),

assets AS (
    SELECT
        serial_number,
        model_number
        --upper(asset_location_country) as country
    FROM service_reports sr
    --WHERE sr.model_brand = 'Merrychef'

),

products AS (
    SELECT
        UPPER(product_number) as product_number,
        product_manufacturer
    FROM {{ ref('stg_tesseract__products') }}
),

asset_details AS (
    SELECT
        serial_number,
        model_number,
        product_number,
        {{  is_valid_serial_number('a.serial_number') }}::boolean  as has_valid_serial,
        {{  is_valid_model_number('a.model_number') }}::boolean as has_valid_model,
        {{  serial_build_date('a.serial_number') }} as build_date,
        {{  serial_build_site('a.serial_number') }} as build_site,
        {{  extract_model_range('a.model_number') }} as range,
        {{  extract_model_variant('a.model_number') }} as variant,
        {{  extract_voltage('a.model_number') }} as voltage,
        {{  extract_model_customer('a.model_number') }} as model_customer,
        {{  extract_model_country('a.model_number') }} as model_country
    FROM assets a
    JOIN products pr ON a.model_number = pr.product_number
    WHERE pr.product_manufacturer = 'MERRYCHEF'
    
),

final AS (
    SELECT * 
    FROM asset_details ad 
    ORDER BY ad.serial_number
)

SELECT * FROM final
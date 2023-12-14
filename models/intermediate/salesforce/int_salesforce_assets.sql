WITH claims AS (
    SELECT * FROM {{ ref('stg_salesforce__claims') }}
),

assets AS (
    SELECT
        serial_number,
        model_number
        --upper(asset_location_country) as country
    FROM claims c
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
        {{  extract_voltage('a.model_number') }} as voltage,
        {{  extract_model_customer('a.model_number') }} as model_customer,
        {{  extract_model_country('a.model_number') }} as model_country
    FROM assets a
),

final AS (
    SELECT * 
    FROM asset_details ad 
    ORDER BY ad.serial_number
)

SELECT * FROM final
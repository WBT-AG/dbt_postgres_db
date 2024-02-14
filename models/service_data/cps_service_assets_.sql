WITH staging_assets AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__assets') }}
),


final AS (
    SELECT 
*,
        {{  serial_build_date('sa.serial_number') }} as build_date,
        {{  serial_build_site('sa.serial_number') }} as build_site,
        {{  extract_model_range('sa.model_number') }} as range,
        {{  extract_model_variant('sa.model_number') }} as variant,
        {{  extract_voltage('sa.model_number') }} as voltage,
        {{  extract_model_customer('sa.model_number') }} as model_customer,
        {{  extract_model_country('sa.model_number') }} as model_country
    FROM staging_assets sa
)

SELECT * from final
WITH staging_claims AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__claims') }}
),

final AS (
    SELECT 
        sc.*,
        {{  is_valid_model_number('sc.model_number') }} as has_valid_model,
        {{  extract_model_range('sc.model_number') }} as range,
        {{  extract_model_variant('sc.model_number') }} as variant,
        {{  extract_voltage('sc.model_number') }} as voltage,
        {{  extract_model_customer('sc.model_number') }} as model_customer,
        {{  extract_model_country('sc.model_number') }} as model_country
    FROM staging_claims sc
)

SELECT * from final
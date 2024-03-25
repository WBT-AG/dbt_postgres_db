WITH staging_assets AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__assets') }}
),


final AS (
    SELECT 
        sa.*,
        {{  is_valid_serial_number('sa.serial_number') }} as has_valid_serial

    FROM staging_assets sa
)

SELECT * from final
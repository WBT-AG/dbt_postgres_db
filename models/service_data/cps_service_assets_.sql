WITH staging_assets AS (
    SELECT 
        *
    FROM {{ ref('stg_salesforce__assets') }}
),


final AS (
    SELECT 
        sa.*,
        {{  is_valid_serial_number('sa.serial_number') }} as has_valid_serial,
        {{  serial_build_date('sa.serial_number') }} as build_date,
        {{  serial_build_site('sa.serial_number') }} as build_site

    FROM staging_assets sa
)

SELECT * from final
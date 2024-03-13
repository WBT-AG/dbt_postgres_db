WITH assets AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_asset')}} 
),

final AS (
    SELECT 
    a.status,
    a.distribution_channel__c as distribution_channel,
    a.series__c as series,
    --a.asset_item_sku__c as sku,
    a.asset_description__c as description,
    a.asset_serial_number__c as serial_number,
    UPPER(a.asset_item_number__c) as model_number,
    a.original_install_date__c as original_install_date,
    UPPER(a.gpl_description__c) as gpl_description,
    a."Id" as asset_id,
    a.original_install_date__c as install_date,
    a.sold_to_ship_to_country__c  as sold_to_country_code
    FROM assets a
    WHERE a.brandtext__c = 'Merrychef' OR a.brandtext__c = 'MERRYCHEF'
)

SELECT * FROM final
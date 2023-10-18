WITH salesforce_warranty_registrations AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_warranty_registration__c')}} 
),

final AS (
    SELECT
        swr.asset__c as asset,
        swr.location_region__c as location_region,
        swr.registration_date__c as registration_date,
        swr."Name" as name,
        swr.asset_serial_number__c as serial_number,
        swr.asset_item_model_number__c as model_number,
        swr.chain_name__c as chain_name,
        swr.brand_name_text__c as brand_name,
        swr."Id" as registration_id,
        swr.install_date__c as install_date,
        swr.purchase_date__c as purchace_date,
        swr.status__c as status,
        swr.item_description__c as item_description,
        swr.serial_number_text__c as serial_number_text,
        swr.asset_location_type__c as asset_location_type
    FROM salesforce_warranty_registrations swr
    WHERE swr.brand_name_text__c = 'MERRYCHEF'
)

-- Select * from Final CTE
SELECT * FROM final
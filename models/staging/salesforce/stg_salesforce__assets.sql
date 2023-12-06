WITH assets AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_asset')}} 
),

final AS (
    SELECT 
    a.status,
    a.distribution_channel__c as distribution_channel,
    a.series__c as series__c,
    a.asset_description__c as description,
    a.asset_serial_number__c as serial_number,
    a.gpl_description__c as gpl_description
    FROM assets a
    WHERE a.brandtext__c = 'Merrychef' OR a.brandtext__c = 'MERRYCHEF'
)

SELECT * FROM final
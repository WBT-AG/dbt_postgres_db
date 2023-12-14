WITH salesforce_parts AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_parts__c')}} 
),

final AS (
    SELECT 
        lastmodifieddate as last_modified_date,
        lastreferenceddate as last_referance_date,
        mpr_effective_date__c as mpr_effective_date,
        "Name" as name,
        active_in_cps__c as active_in_cps,
        item_supersession_date__c as item_supression_date,
        brand__c as brand,
        item_uom__c as item_umo,
        currencyisocode as currency_iso_code,
        code_brand__c as code_brand,
        component_code__c as component_code,
        mpr_end_date__c as mpr_end_date,
        createddate as createddate,
        "Id" as id
    FROM salesforce_parts
)

SELECT * FROM final
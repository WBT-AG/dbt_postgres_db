WITH salesforce_service_lines AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_service_incident_line__c')}} 
),

final AS (
    SELECT
        ssl.approved_qty__c as approved_quantity,
        ssl.approved_rate_charge__c as approved_rate_charge,
        ssl.asset__c as asset_id,
        ssl.asset_brand__c as asset_brand,
        ssl.brandmatches__c as brandmatches,
        ssl.causal_part__c as causal_part,
        ssl.claim__c as claim_id,
        ssl.claim_final__c as claim_final,
        ssl.complaint__c as complaint,
        ssl.component_code__c as component_code,
        ssl.createddate as created_date,
        ssl.currencyisocode as currency,
        ssl.description_other__c as description_other,
        ssl.expense_type_causal_action__c as expense_type_causal_action,
        ssl.failure_mode__c as failure_mode,
        ssl.hours__c as hours,
        ssl."Id" as service_line_id,
        ssl.incident_type__c as incident_type,
        ssl.is_calculated_rate__c as is_calculated_rate,
        ssl."Name" as name,
        ssl.oem__c as oem,
        ssl.part_description__c as part_description,
        ssl.part_number__c as part_number,
        ssl.requested_qty__c as requested_quantity,
        ssl.requested_rate_charge__c as requested_rate_charge,
        ssl.rma_tag__c as rma_tag,
        ssl.service_line_type__c as service_line_type,
        ssl.total_approved__c as total_approved,
        ssl.total_part_labor__c as total_part_labor,
        ssl.total_requested__c as total_requested
    FROM salesforce_service_lines ssl
    WHERE ssl.asset_brand__c = 'MERRYCHEF'
)

-- Select * from Final CTE
SELECT * FROM final
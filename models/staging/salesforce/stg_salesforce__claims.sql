WITH salesforce_claims AS (
    SELECT * FROM {{ source('salesforce', 'airbyte_claim__c')}} 
),

salesforce_assets AS (
    SELECT
        serial_number, 
        install_date,
        build_date
    FROM {{ ref('stg_salesforce__assets') }}
),

final AS (
    SELECT
        sc.account__c as account,
        sc.approval_process_complete__c as approval_process_complete,
        sc.approval_process_rejection__c as approval_process_rejection,
        sc.approved_denied_reason__c as approved_denied_reason,
        sc.approved_labor__c as approved_labor,
        sc.approved_other__c as approved_other,
        sc.approvedoverrequested__c as approved_over_requested,
        sc.approved_parts__c as approved_parts_value,
        sc.approved_travel__c as approved_travel_value,
        sc.asset_location_country__c as asset_location_country,
        sc.asset_location_name__c as asset_location_name,
        sc.asset_location_postal_zip_code__c as asset_location_postal_code,
        sc.asset_location_state_province__c as asset_location_state,
        sc.asset_location_type__c as asset_location_type,
        sc.authorized_by__c as authorised_by,
        sc.business_individual__c as business_individual,
        sc.claim_type__c as claim_type,
        sc.causal_part_added__c as causal_part_added,
        sc.chain_name__c as chain_name,
        sc.charge_type__c as charge_type,
        sc.chargeback_claim__c as chargeback_claim,
        sc.city__c as city,
        sc."Name" as claim_name,
        sc.claim_status__c as claim_status,
        sc.closed_date__c as closed_date,
        sc.closed_date_sas__c as closed_date_sas,
        sc.company_name__c as company_name,
        sc.country__c as country,
        sc.createdbyid as created_by_id,
        cast(sc.createddate as DATE) as created_date,
        sc.currencyisocode as currency,
        sc.currency__c as currency_name,
        sc.date_call_received_returned__c as date_call_received_returned,
        sc.date_service_requested__c as date_service_requested,
        sc.newdate_service_requested__c as new_date_service_requested,
        sc.date_servicer_arrived_on_site__c as date_servicer_arrived_on_site,
        sc.date_submitted__c as date_submitted,
        sc.days_aged__c as days_aged,
        sc.days_submitted_after_repairs_completed__c as days_submitted_after_repairs_completed,
        sc.days_to_submit_claim__c as days_to_submit_claim,
        sc.days_until_servicer_arrived__c as days_until_servicer_arrived,
        sc.difference_labor__c as difference_labor,
        sc.difference_parts__c as difference_parts,
        sc.draft_days__c as draft_days,
        sc.draft_days_aged__c as draft_days_aged,
        sc.equipment_registration_hold__c as equipment_registration_hold,
        sc.erp_error__c as erp_error,
        sc.excessive_claims__c as excessive_claim,
        sc.failure_date__c as failure_date,
        sc.failure_date_time__c as failure_date_time,
        sc.failure_time__c as failure_time,
        sc."Id" as claim_id,
        sc.in_approval_process__c as in_approval_process,
        sc.interface_name__c as interface_name,
        sc.interface_region__c as interface_region,
        sc.invoice_date__c as invoice_date,
        sc.invoice_number__c as invoice_number,
        upper(sc.item_number__c) as model_number,
        sc.item_description__c as item_description,
        sc.lastactivitydate as last_activity_date,
        sc.lastmodifieddate as last_modified_date,
        sc.lastreferenceddate as last_referance_date,
        sc.leaklocation__c as leaklocation,
        sc.left_hand_cycles__c as left_hand_cycles,
        sc.location_sub_region__c as location_sub_region,
        sc.manufacturing_plant__c as manufacturing_plant,
        sc.serial_number_text__c as mcf_serial_number,
        upper(sc.model_item_number__c) as model_item_number,
        sc.non_serialized_item__c as non_serialised_item,
        sc.non_serialized_reason__c as non_serialized_reason,
        sc.non_serialized_reason_other__c as non_serialized_reason_other,
        sc.open_returns__c as open_returns,
        sc.originclaim__c as originclaim,
        sc.owner_city_town__c as owner_city_town,
        sc.owner_company_name__c as owner_company_name,
        sc.owner_country__c as owner_country,
        sc.ownerid as owner_id,
        sc.owner_postal_zip_code__c as owner_postal_code,
        sc.owner_state_province__c as owner_state,
        sc.parent_claim__c as parent_claim,
        sc.payment_processed__c as payment_processed,
        sc.phone_call_made_to_servicer_date__c as phone_call_made_to_servicer_date,
        sc.postal_zip_code__c as postal_code,
        sc.processor_path_status__c as processor_path_status,
        sc.purchase_date__c as purchace_date,
        sc.qad_accountability_code__c as qad_accountability_code,
        sc.qad_coverage_code__c as qad_coverage_code,
        sc.queue_owner__c as queue_owner,
        sc.reason_for_service__c as reason_for_service,
        sc.location_region__c as region,
        sc.repair_completed_date_time__c as repair_completed_date_time,
        sc.repair_completed_date__c as repair_completion_date,
        sc.repair_complete_time__c as repair_completion_time,
        sc.days_to_complete_repair__c as repair_completion_days,
        sc.replacement_part_install_date__c as repalcement_part_install_date,
        sc.replacement_part_invoice__c as replacement_part_invoice,
        sc.replacement_part_invoice_date__c as replacement_part_invoice_date,
        sc.requested_labor__c as requested_labor,
        sc.requested_parts__c as requested_parts_value,
        sc.sent_to_erp__c as sent_to_erp,
        sc.serial_search__c as serial_number,
        sc.service_authorization__c as service_authorisation,
        sc.service_company__c as service_company,
        sc.service_company_leased_product__c as service_company_leased_asset,
        sc.service_company_sold_product__c as service_company_sold_product,
        sc.reason_for_delay_of_service__c as service_delay_reason,
        sc.service_incident_lines_w_complaint__c as service_incident_lines_w_complaint,
        sc.service_incident_summary__c as service_incident_summary,
        sc.servicer_account__c as servicer_account_id,
        sc.servicer_region__c as servicer_region,
        sc.servicer_sub_region__c as servicer_sub_region,
        sc.state_province__c as state_province,
        sc.sub_agent_invoice_date__c as sub_agent_invoice_date,
        sc.submitter_path_status__c as submission_status,
        sc.submiterrors__c as submit_errors,
        sc.submitted_by__c as submitted_by,
        sc.submitter_performed_work__c as submitter_performed_work,
        sc.submitter_region__c as submitter_region,
        sc.systemmodstamp as system_modified_date,
        sc.technician_id__c as technician_id,
        sc.technician_name__c as technician_name,
        sc.total_approved__c as total_approved,
        sc.total_approved_amt__c as total_approved_ammount,
        sc.total_claim_value__c as total_claim_value,
        sc.total_requested_amt__c as total_requested_amount,
        sc.no_of_trips_to_job_site__c as trips_to_site,
        sc.verify_registration__c as verify_registration,
        sc.warranty_registration__c as warranty_registration,
        sc.welbilt_asset_brand__c as welbilt_asset_brand,
        sc.welbilt_brand__c as welbilt_brand_id,
        sc.legacy_id__c as legacy_id,
        CAST(
            CASE
                WHEN LENGTH(sc.serial_search__c) = 13 AND
                    sc.serial_search__c ~ '^[0-9]+$'
                THEN sc.serial_search__c
                ELSE NULL
            END as VARCHAR
        ) as serial_number_cleaned,
        -- Calculate age_at_failure in years
        CASE 
            WHEN sa.build_date IS NOT NULL AND sc.failure_date__c IS NOT NULL 
            THEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.build_date)
            ELSE NULL 
        END AS age_at_failure_years,
        -- Calculate service_age_at_failure in years
        CASE 
            WHEN sa.install_date IS NOT NULL AND sc.failure_date__c IS NOT NULL 
            THEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.install_date)
            ELSE NULL 
        END AS service_age_at_failure_years,
        -- Grouping service_age_at_failure
        CASE
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.install_date) <= 1 THEN '<1 Year'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.install_date) BETWEEN 1 AND 3 THEN '1-3 Years'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.install_date) BETWEEN 4 AND 5 THEN '4-5 Years'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.install_date) >= 6 THEN '6 Years+'
            ELSE NULL
        END AS service_age_at_failure_group,
        -- Grouping age_at_failure
        CASE
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.build_date) < 1 THEN '<1 Year'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.build_date) BETWEEN 1 AND 3 THEN '1-3 Years'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.build_date) BETWEEN 4 AND 5 THEN '4-5 Years'
            WHEN EXTRACT(YEAR FROM sc.failure_date__c) - EXTRACT(YEAR FROM sa.build_date) >= 6 THEN '6 Years+'
            ELSE NULL
        END AS age_at_failure_group
    FROM salesforce_claims sc
    LEFT JOIN salesforce_assets sa ON sa.serial_number = sc.serial_search__c
    WHERE sc.welbilt_asset_brand__c = 'MERRYCHEF' OR sc.welbilt_asset_brand__c = 'Merrychef'
)

-- Select * from Final CTE
SELECT * FROM final
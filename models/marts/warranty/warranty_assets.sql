WITH tesseract_assets AS (
    SELECT
        'Tesseract' as source_system, 
        serial_number,
        model_number,
        has_valid_serial,
        has_valid_model,
        build_date,
        build_site,
        range,
        variant,
        voltage,
        model_customer,
        model_country 
    FROM {{ ref('int_tesseract_assets') }}
),

salesforce_assets AS (
    SELECT
        'Salesforce' as source_system,
        serial_number,
        model_number,
        has_valid_serial,
        has_valid_model,
        build_date,
        build_site,
        range,
        variant,
        voltage,
        model_customer,
        model_country 
    FROM {{ ref('int_salesforce_assets') }}
),


-- Custom Logic: Add your transformations here if needed
Final AS(
    SELECT * from tesseract_assets
    UNION
    SELECT * FROM salesforce_assets
    ORDER BY build_date
)

-- Select * from Final CTE
SELECT * FROM Final

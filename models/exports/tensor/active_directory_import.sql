WITH employees AS (
    SELECT  
        employeeid,
        firstname,
        lastname,
        middlename,
        departmentid,
        siteid,
        employmentenddate,
        employmenttype,
        companyid,
        employeecode
    FROM {{ source('tensor', 'airbyte_employee')}}
    WHERE employeecode::text ~ '^[0-9]+$' -- drops all employee that contain letters
),

departments AS (
    SELECT 
        departmentid,
        departmentcode,
        description
    FROM {{ source('tensor', 'airbyte_department')}} 
),

employee_details AS (
    SELECT
        employeeid,
        country,
        knownas
    FROM {{ source('tensor', 'airbyte_basicdetail')}} 
),

country AS (
    SELECT
        countryid,
        countrycode
    FROM {{ source('tensor', 'airbyte_country')}} 
),

site AS (
    SELECT
        siteid,
        sitecode
    FROM {{ source('tensor', 'airbyte_site')}} 
),

fixedcontrolitem AS (
    SELECT
        fixedcontrolitemid,
        controlvalue
    FROM {{ source('tensor', 'airbyte_fixedcontrolitem')}} 
),

employment_details AS (
    SELECT
        employeeid,
        "Position" as position
    FROM {{ source('tensor', 'airbyte_employmentdetails')}}
),

positions AS (
    SELECT
        positionid,
        jobtitle
    FROM {{ source('tensor', 'airbyte_position')}} 
),

company AS (
    SELECT
        companyid,
        companyname
    FROM {{ source('tensor', 'airbyte_company')}} 
),

supervisor AS (
    SELECT
        employeeid,
        supervisorid
    FROM {{ source('tensor', 'airbyte_vssmsupervisor')}} 
),

misc_text AS (
    SELECT
        employeeid,
        misccolumn,
        employeemisctextitemid
    FROM {{ source('tensor', 'airbyte_employeemisctext')}}
    WHERE misccolumn = 10
),

misc_text_item AS (
    SELECT
        employeemisctextitemid,
        misctext
    FROM {{ source('tensor', 'airbyte_employeemisctextitem')}} 
),

employee_locations AS (
    SELECT
        location,
        division,
        office
    FROM {{ source('imports', 'employee_locations')}} 
),


final AS (
    SELECT
        em.employeeid as id,
        em.employeecode as EmployeeCode,
        em.firstname as FirstName,
        em.lastname as LastName,
        left(em.middlename,1) as MiddleInitial,
        po.jobtitle as JobTitle,
        de.description as department,
        mti.misctext as location,
        LEFT(el.division, 4) as devision,
        el.office,
        --su.supervisorid,
        ed.knownas as preferredFirstName,
        CASE
            WHEN fi.controlvalue like 'Full Time' OR fi.controlvalue = 'Part Time' THEN 'Employee'
            WHEN fi.controlvalue like 'Temps -%' THEN 'Contingent'
            ELSE fi.controlvalue
        END as assignmenttype,
        --fi.controlvalue as AssignmentType,
        si.sitecode as LocationCode,
        co.countrycode as CountryCode,
        cp.companyname as CompanyName,
        CASE
            WHEN em.employmentenddate < CURRENT_DATE THEN
            'S'
            ELSE 'A' 
        END as activeemployee
    FROM employees em
    LEFT JOIN departments de ON em.departmentid = de.departmentid
    LEFT JOIN employee_details ed ON em.employeeid = ed.employeeid
    LEFT JOIN site si ON em.siteid = si.siteid
    LEFT JOIN country co ON ed.country = co.countryid
    LEFT JOIN fixedcontrolitem fi ON em.employmenttype = fi.fixedcontrolitemid
    LEFT JOIN employment_details emd ON em.employeeid = emd.employeeid
    LEFT JOIN positions po ON emd.Position = po.positionid
   -- LEFT JOIN supervisor su ON em.employeeid = su.employeeid
    LEFT JOIN company cp ON em.companyid = cp.companyid
    LEFT JOIN misc_text mt ON em.employeeid = mt.employeeid
    LEFT JOIN misc_text_item mti ON mt.employeemisctextitemid = mti.employeemisctextitemid
    LEFT JOIN employee_locations el ON mti.misctext = el.location
    ORDER BY id
)


-- Select * from Final CTE
SELECT * FROM final

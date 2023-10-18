WITH chat_sessions AS (
    SELECT * FROM {{ source('tech_assist', 'airbyte_merrychef_chat_sessions_view')}} 
),

final AS (
    SELECT
        chat_sessions.custom_prop0 as service_company,
        chat_sessions.agent as agent,
        chat_sessions.stc as stc,
        chat_sessions.session_id as session_id,
        chat_sessions.serial_number as serial_number,
        chat_sessions.source as source,
        chat_sessions.problem as problem_description,
        chat_sessions.model_number as model_number,
        chat_sessions.timestamp as timestamp,
        DATE(chat_sessions.timestamp) as date,
        CAST(
            CASE
                WHEN chat_sessions.serial_number ~ '^[0-9]{13}$' AND 
                     LENGTH(chat_sessions.serial_number) >= 6 AND
                     (SUBSTRING(chat_sessions.serial_number, 1, 2)::int >= 1 AND
                      SUBSTRING(chat_sessions.serial_number, 1, 2)::int <= 31) AND
                     (SUBSTRING(chat_sessions.serial_number, 3, 2)::int >= 1 AND
                      SUBSTRING(chat_sessions.serial_number, 3, 2)::int <= 12) AND
                     (SUBSTRING(chat_sessions.serial_number, 7, 3) IN ('570', '571', '309')) AND
                     TO_DATE(
                        CONCAT('20', SUBSTRING(chat_sessions.serial_number, 5, 2), SUBSTRING(chat_sessions.serial_number, 3, 2), SUBSTRING(chat_sessions.serial_number, 1, 2)),
                        'YYYYMMDD'
                     ) IS NOT NULL
                THEN chat_sessions.serial_number
                ELSE NULL
            END as VARCHAR
        ) as serial_number_cleaned
    FROM chat_sessions
)

-- Select * from Final CTE
SELECT * FROM final

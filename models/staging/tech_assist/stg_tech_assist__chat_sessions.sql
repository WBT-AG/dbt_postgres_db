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
         DATE(chat_sessions.timestamp) as date
    FROM chat_sessions
)


-- Select * from Final CTE
SELECT * FROM final
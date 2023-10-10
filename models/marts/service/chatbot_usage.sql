WITH chat_sessions AS (
    SELECT * FROM {{ ref('stg_tech_assist__chat_sessions') }}
),

-- Custom Logic: Add your transformations here if needed
Final AS(
    SELECT 
        *
    FROM chat_sessions
)

-- Select * from Final CTE
SELECT * FROM Final

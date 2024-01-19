WITH rollout AS (
    SELECT * FROM {{ ref('stg_google_sheets__th_rollout') }}
),


Final AS (
    SELECT
        *
    FROM rollout

)

SELECT * FROM Final

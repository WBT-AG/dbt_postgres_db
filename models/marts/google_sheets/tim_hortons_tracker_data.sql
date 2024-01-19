WITH rollout AS (
    SELECT * FROM {{ ref('stg_google_sheets__th_tracker_data') }}
),


Final AS (
    SELECT
        *
    FROM rollout

)

SELECT * FROM Final

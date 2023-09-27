WITH daily_page_views AS (
    SELECT * FROM {{ ref('stg_ga4__page_views') }}
)

SELECT * from daily_page_views
WITH ga4_daily_page_views AS (
    SELECT * FROM {{ ref('stg_ga4__daily_page_views') }}
),

ga_daily_page_views AS (
    SELECT * FROM {{ ref('stg_ga__daily_page_views') }}
),

combined_views AS (
    SELECT * 
    FROM ga4_daily_page_views
    UNION ALL
    SELECT *
    FROM ga_daily_page_views
),

weighted_metrics AS (
    SELECT
        date,
        base_url,
        path,
        views,
        bounce_rate,
        bounce_rate * views AS weighted_bounce_rate
    FROM combined_views
),

daily_metrics AS (
    SELECT
        date,
        base_url,
        path,
        SUM(views) AS total_views,
        SUM(weighted_bounce_rate) AS total_weighted_bounce_rate
    FROM weighted_metrics
    GROUP BY date, base_url, path
),

Final AS (
    SELECT
        dm.date,
        dm.base_url,
        dm.path,
        dm.total_views as views,
        CASE
            WHEN dm.total_views > 0 THEN dm.total_weighted_bounce_rate / dm.total_views
            ELSE 0  -- You can choose an appropriate value for cases where total_views is zero
        END AS bounce_rate
    FROM daily_metrics dm
)

SELECT * FROM Final

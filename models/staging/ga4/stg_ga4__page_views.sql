WITH ga4_page_views AS (
    SELECT * FROM {{ source('ga4', 'airbyte_pages')}} 
),

final AS (
    SELECT
        TO_DATE(ga4_page_views.date, 'YYYYMMDD') as date,
        ga4_page_views.hostname as base_url,
        SPLIT_PART(ga4_page_views.pagepathplusquerystring, '?', 1) as path,
        ga4_page_views.screenpageviews as views,
        ga4_page_views.bouncerate as bounce_rate
    FROM ga4_page_views
)


-- Select * from Final CTE
SELECT * FROM final
WITH ga_page_views AS (
    SELECT * FROM {{ source('ga', 'airbyte_pages')}} 
),

final AS (
    SELECT
        ga_page_views.ga_date as date,
        ga_page_views.ga_hostname as base_url,
        SPLIT_PART(ga_page_views.ga_pagepath, '?', 1) as path,
        ga_page_views.ga_pageviews as views,
        ga_page_views.ga_bouncerate/100 as bounce_rate
    FROM ga_page_views
    WHERE ga_page_views.ga_date <= '2023-06-06'
)


-- Select * from Final CTE
SELECT * FROM final
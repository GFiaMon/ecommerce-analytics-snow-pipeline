{{
    config(
        materialized='table',
        alias='top_category_per_client_year',
        schema='sales',
        tags=['sales_mart']
    )
}}

WITH dim_client AS (SELECT * FROM {{ ref('dim_client') }}),
     dim_product AS (SELECT * FROM {{ ref('dim_product') }}),
     dim_time AS (SELECT * FROM {{ ref('dim_time') }}),
     fact_sales AS (SELECT * FROM {{ ref('fact_sales') }}),

-- Step 1: Aggregate total purchases per client/year/category
sales_aggregated AS (
  SELECT
    c.client_name,
    t.cal_year,
    p.category,
    SUM(f.quantity * f.unit_price) AS total_revenue
  FROM fact_sales f
  JOIN dim_time t ON f.date_id = t.date_id
  JOIN dim_product p ON f.product_id = p.product_id
  JOIN dim_client c ON c.client_id = f.client_id
  GROUP BY 1, 2, 3
),

-- Step 2: Rank categories by revenue within client/year groups
ranked_categories AS (
  SELECT
    client_name,
    cal_year,
    category,
    total_revenue,
    ROW_NUMBER() OVER (
      PARTITION BY client_name, cal_year
      ORDER BY total_revenue DESC
    ) AS category_rank
  FROM sales_aggregated
)

-- Step 3: Filter to the top-ranked category per client/year
SELECT
  client_name,
  cal_year,
  category AS most_bought_category,
  total_revenue
FROM ranked_categories
WHERE category_rank = 1
ORDER BY client_name, cal_year

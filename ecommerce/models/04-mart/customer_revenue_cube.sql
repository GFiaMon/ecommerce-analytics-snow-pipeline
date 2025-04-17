{{
    config(
        materialized='table',
        alias='customer_revenue_cube',
        schema='sales',
        tags=['sales_mart']
    )
}}

with dim_client as (
    select * 
    from {{ ref('dim_client')}}
),
dim_product as (
    select * 
    from {{ ref('dim_product')}}
),
dim_time as (
    select * 
    from {{ ref('dim_time')}}
),
fact_sales as (
    select * 
    from {{ ref('fact_sales')}}
)

SELECT
  COALESCE(c.client_name, 'ALL_CUSTOMERS') AS client_name,
  COALESCE(CAST(t.cal_year AS VARCHAR), 'ALL_YEARS') as year,
  COALESCE(p.category, 'ALL_CATEGORIES') AS product_category,
  SUM(f.quantity*f.unit_price) AS total_revenue
FROM
  fact_sales AS f
  JOIN dim_time AS t ON f.date_id = t.date_id
  JOIN dim_product AS p ON f.product_id = p.product_id
  JOIN DIM_CLIENT AS c on c.client_id = f.client_id
GROUP BY
  CUBE (c.client_name, t.cal_year, p.category)
ORDER BY
  c.client_name,
  t.cal_year,
  p.category
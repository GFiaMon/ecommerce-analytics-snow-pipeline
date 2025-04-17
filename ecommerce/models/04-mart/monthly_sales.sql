{{
    config(
        alias='agg_sales_monthly',
        schema='sales',
        materialized='table',
        tags=['sales_mart']
    )
}}

with dim_product as (
    select * 
    from {{ ref('dim_product')}}
),

dim_time as (
    select * 
    from {{ ref('dim_time')}}
),
dim_client as (
    select * 
    from {{ ref('dim_client')}}
),
fact_sales as (
    select * 
    from {{ ref('fact_sales')}}
)

SELECT
  d.cal_year,
  d.cal_quarter,
  p.category,
  SUM(f.unit_price * f.unit_price) AS total_sales
FROM fact_sales f
JOIN dim_time d ON f.date_id = d.date_id
JOIN dim_client c ON f.client_id = c.client_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY CUBE (d.cal_year,d.cal_quarter, c.status_name, p.category)
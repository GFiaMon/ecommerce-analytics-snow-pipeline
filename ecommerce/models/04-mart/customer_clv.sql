{{
    config(
        materialized='table',
        alias='client_lifetime_value',
        schema='sales',
        tags=['sales_mart']
    )
}}

with fact_sales as (
    select * 
    from {{ ref('fact_sales')}}
),

dim_client as (
    select * 
    from {{ ref('dim_client')}}
)

SELECT
    c.CLIENT_ID,
    client_name,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(quantity * unit_price) as total_revenue,
   ROUND (avg(quantity * unit_price), 2) as avg_order
FROM
    fact_sales AS fs
JOIN
    dim_client AS c ON fs.client_id = c.client_id
GROUP BY
    c.CLIENT_ID, client_name
ORDER BY
    total_revenue desc
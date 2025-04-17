{{
  config(
    materialized='table',
    alias='monthly_sales_by_category',
    schema='sales',
    tags=['sales'])
}}

SELECT 
    t.CAL_YEAR, 
    t.cal_month, 
    p.category, 
    SUM(fs.quantity * fs.unit_price) AS total_sales
FROM 
    {{ ref('fact_sales') }} fs
LEFT JOIN 
    {{ ref('dim_product') }} p ON fs.product_id = p.product_id
LEFT JOIN 
    {{ ref('dim_time') }}  t ON fs.date_id = t.date_id
GROUP BY
    t.CAL_YEAR, 
    t.CAL_MONTH, 
    p.category
ORDER BY 
    t.CAL_YEAR, t.CAL_MONTH, p.category
{{
    config(
        materialized='table',
        alias='top_10_products_',
        schema='sales',
        tags=['sales_mart']
    )
}}

WITH RankedProducts AS (
    SELECT
        t.cal_mon_name,
        p.PRODUCT_NAME,
        SUM(fs.QUANTITY * fs.UNIT_PRICE) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY t.cal_mon_name ORDER BY SUM(fs.QUANTITY * fs.UNIT_PRICE) DESC) AS rank
    FROM
        {{ ref('fact_sales') }} AS fs
    JOIN
        {{ ref('dim_product') }} AS p ON fs.product_id = p.product_id
    JOIN
        {{ ref('dim_time') }} AS t ON fs.date_id = t.date_id
    GROUP BY
        t.cal_mon_name,
        p.PRODUCT_NAME
)
SELECT
    cal_mon_name,
    PRODUCT_NAME,
    total_revenue
FROM
    RankedProducts
WHERE
    rank <= 10
ORDER BY
    cal_mon_name,
    total_revenue DESC
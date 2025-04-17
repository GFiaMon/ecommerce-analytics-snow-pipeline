{{
    config(
        alias='fact_sales',
        materialized='table',
        tags=['star_schema']
    )

}}

WITH orders AS (
    SELECT
        order_id,
        client_id,
        payment_id,
        order_date,
        status,
        total_amount,
    FROM {{ source('ecommerce', 'orders')}}
),

order_product AS (
    SELECT
        order_product_id,
        order_id,
        product_id,
        quantity,
        price_unit
    FROM {{ source('ecommerce', 'order_product')}}
),

payment_method AS (
    SELECT *
    FROM {{ source('ecommerce', 'payment_method')}}
),

dim_time AS (
    SELECT *
    FROM
        {{ ref('dim_time') }}
),

orders_with_dates AS (
    SELECT
        o.client_id,
        op.product_id,
        t.date_id,
        o.order_id,
        op.order_product_id,
        o.status AS order_status,
        op.quantity,
        pm.payment_method,
        op.price_unit AS unit_price,
        o.total_amount AS total_order_price
    FROM
        orders AS o
    JOIN order_product AS op
        ON o.order_id = op.order_id
    LEFT JOIN payment_method AS pm
        ON o.payment_id = pm.payment_id
    LEFT JOIN dim_time AS t
        on t.calendar_date = TO_DATE(o.ORDER_DATE)
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['client_id', 'product_id', 'date_id', 'order_id', 'order_product_id']) }} AS sales_id,
    client_id,
    product_id,
    date_id,
    order_id,
    order_product_id,
    order_status,
    quantity,
    payment_method,
    unit_price,
    total_order_price
FROM
    orders_with_dates
--
-- Compare this snippet from DBT_Project/ecommerce/models/03-star_schema/dim_time.sql
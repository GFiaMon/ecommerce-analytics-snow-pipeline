{{
    config(
        alias='dim_client',
        materialized='table',
        tags=['star_schema']
    )

}}

with client as (
    select * 
    from {{ source('ecommerce', 'client')}}
),
client_status as (
    select * 
    from {{ source('ecommerce', 'client_status')}}
),
client_type as (
    select * 
    from {{ source('ecommerce', 'client_type')}}
)

SELECT
    c.client_id,
    ct.type_name,
    cs.status_name,
    c.client_name,
    c.email,
    c.phone_number,
    c.address,
    TO_DATE(c.registration_date) as registration_date
FROM
    client as c
LEFT JOIN
    client_type AS ct
    USING (type_id)
LEFT JOIN
    client_status AS cs
    USING (status_id)

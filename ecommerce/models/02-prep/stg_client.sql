{{
    config(
        alias='stg_client',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'client')}}
)

select 
    client_id,
    client_name, 
    email, 
    phone_number, 
    address, 
    type_id, 
    status_id, 
    TO_DATE(registration_date) as registration_date
from 
    source
order by
    registration_date
{{
    config(
        alias='stg_orders',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'orders')}}
)

select 
    *
from 
    source
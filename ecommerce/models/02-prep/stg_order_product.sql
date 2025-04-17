{{
    config(
        alias='stg_order_product',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'order_product')}}
)

select 
    *
from 
    source

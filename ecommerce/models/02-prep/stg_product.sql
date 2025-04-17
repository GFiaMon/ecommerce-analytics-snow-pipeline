{{
    config(
        alias='stg_product',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'product')}}
)

select 
    *
from 
    source
{{
    config(
        alias='stg_payment_method',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'payment_method')}}
)

select 
    *
from 
    source
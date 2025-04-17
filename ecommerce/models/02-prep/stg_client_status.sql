{{
    config(
        alias='stg_client_status',
        materialized='table',
        tags=['staging']
    )

}}

with source as (
    select * 
    from {{ source('ecommerce', 'client_status')}}
)

select 
    *
from 
    source

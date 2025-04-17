-- models/02-prep/dim_time.sql
{{
    config(
        alias='dim_time',
        materialized='table',
        tags=['star_schema']
    )
}}

{{ generate_dates_dimension("2015-01-01") }}

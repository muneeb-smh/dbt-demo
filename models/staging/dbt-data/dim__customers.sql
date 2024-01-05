{{ 
    config(
        target_database='dbt-cloud',
        target_schema='dbt_shussain',
        materialized='table'
    ) 
}}
with stg__customers as (
    select * from
    {{ ref('snapshot__customers') }}
)
select
    md5(stg__customers.customer_id) as customer_key,
    stg__customers.customer_id,
    stg__customers.customer_unique_id,
    stg__customers.customer_zip_code_prefix,
    stg__customers.customer_city,
    stg__customers.customer_state
from stg__customers
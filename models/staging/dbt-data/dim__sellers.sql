{{ 
    config(
        target_database='dbt-cloud',
        target_schema='dbt_shussain',
        materialized='table'
    ) 
}}
with stg__sellers as (
    select * from
    {{ ref('snapshot__sellers') }}
)
select
    md5(stg__sellers.seller_id) as seller_key,
    stg__sellers.seller_id,
    stg__sellers.seller_zip_code_prefix,
    stg__sellers.seller_city,
    stg__sellers.seller_state
from stg__sellers
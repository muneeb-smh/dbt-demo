{{ 
    config(
        target_database='dbt-cloud',
        target_schema='dbt_shussain',
        materialized='table'
    ) 
}}
with 

source as (

    select * from {{ source('dbt-data', 'product_translations') }}

),

renamed as (

    select
        product_category_name,
        product_category_name_english

    from source

)

select * from renamed

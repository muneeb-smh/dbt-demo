{{ 
    config(
        target_database='dbt-cloud',
        target_schema='dbt_shussain',
        materialized='table'
    ) 
}}
with 

source as (

    select * from {{ source('dbt-data', 'order_payments') }}

),

renamed as (

    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value

    from source

)

select * from renamed

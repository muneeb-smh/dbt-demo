{% snapshot snapshot__customers %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt_shussain',
      unique_key='customer_id',
      strategy='check',
      check_cols=['all'],
    )
}}

select 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from {{ source('dbt-data', 'customers') }}

{% endsnapshot %}
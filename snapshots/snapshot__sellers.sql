{% snapshot snapshot__sellers %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt_shussain',
      unique_key='seller_id',
      strategy='check',
      check_cols=['all'],
    )
}}

select 
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
from {{ source('dbt-data', 'sellers') }}

{% endsnapshot %}
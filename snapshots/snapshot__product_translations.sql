{% snapshot snapshot__product_translations %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt_shussain',
      unique_key='product_category_name',
      strategy='check',
      check_cols=['all'],
    )
}}

select 
    product_category_name,
    product_category_name_english
from {{ source('dbt-data', 'product_translations') }}

{% endsnapshot %}
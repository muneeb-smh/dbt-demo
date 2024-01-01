{% snapshot products_snapshot %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt_shussain',
      unique_key='product_id',
      strategy='check',
      check_cols=['all'],
    )
}}

select * from {{ source('dbt-data', 'products') }}

{% endsnapshot %}
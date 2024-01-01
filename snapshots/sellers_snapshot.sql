{% snapshot sellers_snapshot %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt_shussain',
      unique_key='seller_id',
      strategy='check',
      check_cols=['all'],
    )
}}

select * from {{ source('dbt-data', 'sellers') }}

{% endsnapshot %}
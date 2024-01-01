{% snapshot customers_snapshot %}

{{
    config(
      target_database='dbt-cloud',
      target_schema='dbt-shussain',
      unique_key='customer_id',
      strategy='check',
      check_cols=['all'],
    )
}}

select * from {{ source('dbt-data', 'customers') }}

{% endsnapshot %}
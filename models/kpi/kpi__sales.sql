with kpi__gmv as 
(
    select 
        date_trunc('month', cast(order_purchase_timestamp as date)) as order_month,
        sum(price) as gmv
    from {{ ref('ads__orders') }}
    group by date_trunc('month', cast(order_purchase_timestamp as date))
),
kpi__nmv as 
(
    select 
        date_trunc('month', cast(order_purchase_timestamp as date)) as order_month,
        sum(case when order_status='delivered' then price else 0 end) as nmv
    from {{ ref('ads__orders') }}
    group by date_trunc('month', cast(order_purchase_timestamp as date))
),
kpi__top_rated_product as
(
    select * from
    (
        select 
            order_month,
            product_category_name as top_rated_product,
            avg_review_score, 
            row_number() over (partition by order_month order by avg_review_score desc) as rn
        from
        (
            select 
                date_trunc('month', cast(order_purchase_timestamp as date)) as order_month,
                product_category_name,
                avg(review_score) avg_review_score
            from {{ ref('ads__orders') }} 
            group by date_trunc('month', cast(order_purchase_timestamp as date)), product_category_name
        ) a
    ) b where rn=1
),
kpi__top_sold_product as
(
    select * from
    (
        select 
            order_month,
            product_category_name as top_sold_product,
            sold_count, 
            row_number() over (partition by order_month order by sold_count desc) as rn
        from
        (
            select 
                date_trunc('month', cast(order_purchase_timestamp as date)) as order_month,
                product_category_name,
                count(*) as sold_count
            from {{ ref('ads__orders') }} 
            group by date_trunc('month', cast(order_purchase_timestamp as date)), product_category_name
        ) a
    ) b where rn=1
),
kpi__mau as
(
    select 
        date_trunc('month', cast(order_purchase_timestamp as date)) as order_month,
        count(distinct customer_key) as mau
    from {{ ref('ads__orders') }} 
    group by date_trunc('month', cast(order_purchase_timestamp as date))
)
select 
    kpi__gmv.order_month,
    kpi__gmv.gmv,
    kpi__nmv.nmv,
    kpi__top_rated_product.top_rated_product,
    kpi__top_sold_product.top_sold_product,
    kpi__mau.mau
from kpi__gmv
inner join kpi__nmv
on kpi__gmv.order_month = kpi__nmv.order_month
inner join kpi__top_rated_product
on kpi__gmv.order_month = kpi__top_rated_product.order_month
inner join kpi__top_sold_product
on kpi__gmv.order_month = kpi__top_sold_product.order_month
inner join kpi__mau
on kpi__gmv.order_month = kpi__mau.order_month
order by kpi__gmv.order_month desc
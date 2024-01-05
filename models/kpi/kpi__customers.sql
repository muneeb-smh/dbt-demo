WITH kpi__gmv AS 
(
    select 
        customer_key,
        days_between_orders
    from
    (
        SELECT 
            customer_key,
            next_order_date - current_order_date AS days_between_orders
        FROM 
        (
            SELECT 
                customer_key,
                CAST(order_purchase_timestamp AS DATE) AS current_order_date,
                LEAD(CAST(order_purchase_timestamp AS DATE), 1) OVER (ORDER BY CAST(order_purchase_timestamp AS DATE)) AS next_order_date
            FROM {{ ref('ads__orders') }}
        ) a
    ) b 
)
SELECT 
    *
FROM kpi__gmv

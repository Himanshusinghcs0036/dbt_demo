with orders as (

    select
        {{ dbt_utils.surrogate_key(['id', 'order_date', 'status']) }} as order_id
        ,customer_id
        ,order_date
        ,status
        ,min(order_date) as first_order
        ,max(order_date) as most_recent_order
        ,count(order_id) as number_of_orders

    from {{ ref('orders')}} orders

    group by order_id, customer_id, order_date, status

)

select * from orders
with

daily as (

    select
        date_date,
        count(distinct orders_id) as nb_transactions,
        sum(revenue) as revenue,
        sum(operational_margin) as operational_margin,
        sum(purchase_cost) as purchase_cost,
        sum(shipping_fee) as shipping_fee,
        sum(logcost) as logcost,
        sum(quantity) as quantity

    from {{ ref('int_orders_operational') }}

    group by date_date

)

select
    date_date,
    nb_transactions,
    revenue,
    round(revenue / nullif(nb_transactions, 0), 2) as average_basket,
    operational_margin,
    purchase_cost,
    shipping_fee,
    logcost,
    quantity

from daily

order by date_date desc
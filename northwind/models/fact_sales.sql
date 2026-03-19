with stg_orders as (
    select
        orderid,
        customerid,
        employeeid,
        replace(to_date(orderdate)::varchar, '-', '')::int as orderdatekey,
        replace(to_date(requireddate)::varchar, '-', '')::int as requireddatekey,
        replace(to_date(shippeddate)::varchar, '-', '')::int as shippeddatekey,
        shipname,
        shipaddress,
        shipcity,
        shipregion,
        shippostalcode,
        shipcountry,
        freight,
        shipvia
    from {{ source('northwind','Orders') }}
),

stg_order_details as (
    select
        orderid,
        productid,
        quantity,
        unitprice,
        discount
    from {{ source('northwind','Order_Details') }}
)

select
    o.orderid,
    {{ dbt_utils.generate_surrogate_key(['od.productid']) }} as productkey,
    {{ dbt_utils.generate_surrogate_key(['o.customerid']) }} as customerkey,
    {{ dbt_utils.generate_surrogate_key(['o.employeeid']) }} as employeekey,
    o.orderdatekey,
    o.requireddatekey,
    o.shippeddatekey,
    o.shipname,
    o.shipaddress,
    o.shipcity,
    o.shipregion,
    o.shippostalcode,
    o.shipcountry,
    o.freight,
    o.shipvia,
    od.quantity,
    od.unitprice,
    od.discount,
    od.quantity * od.unitprice as extendedamount,
    od.quantity * od.unitprice * (1 - od.discount) as discountedamount
from stg_orders o
join stg_order_details od
    on o.orderid = od.orderid
    
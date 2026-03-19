with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
),
d_supplier as (
    select * from {{ ref('dim_supplier') }}
),
d_category as (
    select * from {{ ref('dim_category') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)

select
    f.orderid,
    f.orderdatekey,
    f.requireddatekey,
    f.shippeddatekey,
    f.shipname,
    f.shipaddress,
    f.shipcity,
    f.shipregion,
    f.shippostalcode,
    f.shipcountry,
    f.freight,
    f.shipvia,
    f.quantity,
    f.unitprice,
    f.discount,
    f.extendedamount,
    f.discountedamount,

    c.customerid,
    c.companyname,
    c.contactname,
    c.contacttitle,
    c.address as customeraddress,
    c.city as customercity,
    c.region as customerregion,
    c.postalcode as customerpostalcode,
    c.country as customercountry,
    c.phone as customerphone,
    c.fax as customerfax,

    e.employeeid,
    e.employeenamelastfirst,
    e.employeenamefirstlast,
    e.employeetitle,
    e.supervisornamelastfirst,
    e.supervisornamefirstlast,

    p.productid,
    p.productname,
    p.quantityperunit,
    p.unitsinstock,
    p.unitsonorder,
    p.reorderlevel,
    p.discontinued,

    s.supplierid,
    s.companyname as suppliercompanyname,
    s.contactname as suppliercontactname,
    s.contacttitle as suppliercontacttitle,
    s.city as suppliercity,
    s.region as supplierregion,
    s.country as suppliercountry,

    cat.categoryid,
    cat.categoryname,
    cat.description as categorydescription,

    d.date,
    d.year,
    d.month,
    d.quarter,
    d.day,
    d.dayofweek,
    d.weekofyear,
    d.dayofyear,
    d.quartername,
    d.monthname,
    d.dayname,
    d.weekday

from f_sales f
left join d_customer c
    on f.customerkey = c.customerkey
left join d_employee e
    on f.employeekey = e.employeekey
left join d_product p
    on f.productkey = p.productkey
left join d_supplier s
    on p.supplierkey = s.supplierkey
left join d_category cat
    on p.categorykey = cat.categorykey
left join d_date d
    on f.orderdatekey = d.datekey
with stg_products as (
    select * 
    from {{ source('northwind','Products') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
    productid,
    {{ dbt_utils.generate_surrogate_key(['supplierid']) }} as supplierkey,
    {{ dbt_utils.generate_surrogate_key(['categoryid']) }} as categorykey,
    productname,
    quantityperunit,
    unitprice,
    unitsinstock,
    unitsonorder,
    reorderlevel,
    discontinued
from stg_products
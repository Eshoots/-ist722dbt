with stg_suppliers as (
    select * 
    from {{ source('northwind','Suppliers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['supplierid']) }} as supplierkey,
    supplierid,
    companyname,
    contactname,
    contacttitle,
    address,
    city,
    region,
    postalcode,
    country,
    phone,
    fax
from stg_suppliers
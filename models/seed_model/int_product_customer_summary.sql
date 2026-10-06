{{ config(materialized='view') }}

select

    c.customer_id,
    c.customer_name,
    c.customer_segment,

    a.account_id,
    a.account_type,

    b.product_group,
    b.description as product_description,

    a.current_balance

from {{ ref('stg_customers') }} c

left join {{ ref('stg_accounts') }} a
    on c.customer_id = a.customer_id

left join {{ ref('banking_reference_codes') }} b
    on upper(a.account_type) = upper(b.product_code)
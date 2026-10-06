{{ config(
    materialized='table'
) }}

select

    c.customer_id,
    c.customer_name,
    c.customer_segment,

    sum(coalesce(t.transaction_amount,0)) as total_transaction_value,

    sum(coalesce(a.current_balance,0)) as total_balance,

    sum(coalesce(l.outstanding_amount,0)) as total_loan_exposure,

    round(
        sum(coalesce(t.transaction_amount,0)) * 0.01,
        2
    ) as estimated_revenue

from {{ ref('dim_customer') }} c

left join {{ ref('dim_account') }} a
    on c.customer_id = a.customer_id

left join {{ ref('fact_transactions') }} t
    on c.customer_id = t.customer_id

left join {{ ref('dim_loan') }} l
    on c.customer_id = l.customer_id

group by
    c.customer_id,
    c.customer_name,
    c.customer_segment
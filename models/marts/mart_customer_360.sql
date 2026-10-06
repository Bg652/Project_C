{{ config(
    materialized='table'
) }}

select

    c.customer_id,
    c.customer_name,
    c.customer_segment,
    c.city,
    c.state,
    c.kyc_status,

    count(distinct a.account_id) as total_accounts,

    count(distinct cr.card_id) as total_cards,

    count(distinct l.loan_id) as total_loans,

    sum(a.current_balance) as total_balance,

    sum(coalesce(t.transaction_amount,0)) as total_transaction_value,

    count(distinct t.transaction_id) as total_transactions

from {{ ref('dim_customer') }} c

left join {{ ref('dim_account') }} a
    on c.customer_id = a.customer_id

left join {{ ref('dim_card') }} cr
    on c.customer_id = cr.customer_id

left join {{ ref('dim_loan') }} l
    on c.customer_id = l.customer_id

left join {{ ref('fact_transactions') }} t
    on c.customer_id = t.customer_id

group by
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    c.city,
    c.state,
    c.kyc_status
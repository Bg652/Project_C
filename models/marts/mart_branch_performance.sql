{{ config(
    materialized='table'
) }}

select

    b.branch_id,
    b.branch_name,
    b.city,
    b.state,

    count(distinct a.account_id) as total_accounts,

    count(distinct t.transaction_id) as total_transactions,

    sum(t.transaction_amount) as transaction_value

from {{ ref('dim_branch') }} b

left join {{ ref('dim_account') }} a
    on b.branch_id = a.branch_id

left join {{ ref('fact_transactions') }} t
    on a.account_id = t.account_id

group by
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
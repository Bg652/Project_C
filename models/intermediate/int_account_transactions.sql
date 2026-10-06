{{ config(materialized='view') }}

select

    t.transaction_id,
    t.account_id,
    t.customer_id,

    a.branch_id,
    a.account_type,
    a.account_status,

    t.transaction_date,
    t.transaction_type,
    t.transaction_channel,
    t.transaction_amount,
    t.currency,
    t.transaction_status

from {{ ref('stg_transactions') }} t

left join {{ ref('stg_accounts') }} a
    on t.account_id = a.account_id
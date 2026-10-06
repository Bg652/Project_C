{{ config(materialized='view') }}

select

    l.loan_id,
    l.customer_id,
    l.account_id,

    l.loan_type,
    l.loan_status,

    l.sanctioned_amount,
    l.outstanding_amount,

    sum(coalesce(p.payment_amount,0)) as total_paid,

    count(p.payment_id) as total_payments

from {{ ref('stg_loans') }} l

left join {{ ref('stg_loan_payments') }} p
    on l.loan_id = p.loan_id

group by
    l.loan_id,
    l.customer_id,
    l.account_id,
    l.loan_type,
    l.loan_status,
    l.sanctioned_amount,
    l.outstanding_amount
{{ config(
    materialized='table'
) }}

select

    loan_type,
    loan_status,

    count(*) as total_loans,

    sum(sanctioned_amount) as total_sanctioned_amount,

    sum(outstanding_amount) as total_outstanding_amount,

    avg(interest_rate) as avg_interest_rate

from {{ ref('dim_loan') }}

group by
    loan_type,
    loan_status
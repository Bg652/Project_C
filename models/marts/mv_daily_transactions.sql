{{ config(
    materialized='materialized_view'
) }}

select
    transaction_date,
    sum(transaction_amount) as total_amount
from {{ ref('fact_transactions') }}
group by transaction_date
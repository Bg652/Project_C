{{ config(
    materialized='table'
) }}

select

    transaction_date,

    count(*) as transaction_count,

    sum(transaction_amount) as transaction_value,

    avg(transaction_amount) as avg_transaction_amount

from {{ ref('fact_transactions') }}

group by transaction_date
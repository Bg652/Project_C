{{ config(materialized='ephemeral') }}

select

    customer_id,

    count(distinct account_id) as total_accounts,

    sum(current_balance) as total_balance,

    min(opening_date) as first_account_date

from {{ ref('stg_accounts') }}

group by customer_id
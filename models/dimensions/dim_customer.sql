{#
This model builds the customer dimension.
Used by mart_customer_360.
#}

{{ config(materialized='table') }}

select

    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    c.customer_segment,
    c.date_of_birth,
    c.signup_date,
    c.kyc_status,

    a.total_accounts,
    a.total_balance,
    a.first_account_date,

    c.source_updated_at,
    c.dbt_loaded_at

from {{ ref('stg_customers') }} c

left join {{ ref('int_customer_activity') }} a
    on c.customer_id = a.customer_id
{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'accounts') }}
 
),
 
standardized as (
 
    select
        trim(account_id) as account_id,
        trim(customer_id) as customer_id,
        trim(branch_id) as branch_id,
        upper(trim(account_type)) as account_type,
        upper(trim(account_status)) as account_status,
        upper(trim(currency)) as currency,
        cast(opening_date as date) as opening_date,
        safe_cast(credit_limit as numeric) as credit_limit,
        safe_cast(current_balance as numeric) as current_balance,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

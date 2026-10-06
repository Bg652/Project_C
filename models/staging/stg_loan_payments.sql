{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'loan_payments') }}
 
),
 
standardized as (
 
    select
        trim(payment_id) as payment_id,
        trim(loan_id) as loan_id,
        cast(payment_date as date) as payment_date,
        safe_cast(payment_amount as numeric) as payment_amount,
        safe_cast(principal_amount as numeric) as principal_amount,
        safe_cast(interest_amount as numeric) as interest_amount,
        upper(trim(payment_status)) as payment_status,
        upper(trim(payment_channel)) as payment_channel,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

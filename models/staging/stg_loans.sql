{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'loans') }}
 
),
 
standardized as (
 
    select
        trim(loan_id) as loan_id,
        trim(customer_id) as customer_id,
        trim(account_id) as account_id,
        upper(trim(loan_type)) as loan_type,
        upper(trim(loan_status)) as loan_status,
        cast(application_date as date) as application_date,
        safe_cast(sanctioned_amount as numeric) as sanctioned_amount,
        safe_cast(interest_rate as numeric) as interest_rate,
        safe_cast(tenure_months as int64) as tenure_months,
        safe_cast(outstanding_amount as numeric) as outstanding_amount,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

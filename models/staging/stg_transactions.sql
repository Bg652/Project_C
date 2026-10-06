{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'transactions') }}
 
),
 
standardized as (
 
    select
        trim(transaction_id) as transaction_id,
        trim(account_id) as account_id,
        trim(customer_id) as customer_id,
        cast(transaction_date as date) as transaction_date,
        upper(trim(transaction_type)) as transaction_type,
        upper(trim(channel)) as transaction_channel,
        safe_cast(amount as numeric) as transaction_amount,
        upper(trim(currency)) as currency,
        upper(trim(transaction_status)) as transaction_status,
        nullif(trim(reference_number), '') as reference_number,
        nullif(trim(description), '') as transaction_description,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

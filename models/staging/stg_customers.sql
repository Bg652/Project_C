{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'customers') }}
 
),
 
standardized as (
 
    select
        trim(customer_id) as customer_id,
        trim(customer_name) as customer_name,
        lower(trim(email)) as email,
        cast(phone as string) as phone,
        trim(city) as city,
        trim(state) as state,
        upper(trim(customer_segment)) as customer_segment,
        cast(date_of_birth as date) as date_of_birth,
        cast(signup_date as date) as signup_date,
        upper(trim(kyc_status)) as kyc_status,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

{{ config(materialized='view') }}
 
with source_data as (
 
    select *
    from {{ source('banksphere', 'branches') }}
 
),
 
standardized as (
 
    select
        trim(branch_id) as branch_id,
        trim(branch_name) as branch_name,
        trim(city) as city,
        trim(state) as state,
        upper(trim(branch_type)) as branch_type,
        cast(opened_date as date) as opened_date,
        upper(trim(region)) as region,
        cast(updated_at as timestamp) as source_updated_at,
        current_timestamp() as dbt_loaded_at
    from source_data
 
)
 
select *
from standardized

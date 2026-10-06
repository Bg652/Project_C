{{ config(materialized='view') }}

select *

from {{ ref('stg_transactions') }}

where transaction_date >= '{{ var("analysis_start_date") }}'
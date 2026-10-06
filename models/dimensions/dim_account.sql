{{ config(materialized='table') }}

select

    {{ dbt_utils.generate_surrogate_key(
        ['account_id','customer_id']
    ) }} as account_sk,

    *

from {{ ref('stg_accounts') }}

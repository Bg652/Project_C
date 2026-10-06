{{
    config(
        materialized='incremental',
        unique_key='transaction_id',
        incremental_strategy='merge',

        partition_by={
            "field": "transaction_date",
            "data_type": "date"
        },

        cluster_by=[
            "account_id",
            "customer_id"
        ]
    )
}}

select

    transaction_id,
    account_id,
    customer_id,
    transaction_date,
    transaction_type,
    transaction_channel,
    transaction_amount,
    {{ classify_transaction('transaction_amount') }} as transaction_category,
    currency,
    transaction_status,
    source_updated_at,
    current_timestamp() as dbt_loaded_at

from {{ ref('stg_transactions') }}

{% if is_incremental() %}

where source_updated_at >
(
    select coalesce(
        max(source_updated_at),
        timestamp('1900-01-01')
    )
    from {{ this }}
)

{% endif %}
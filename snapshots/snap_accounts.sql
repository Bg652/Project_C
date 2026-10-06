{% snapshot snap_accounts %}

{{
    config(
        target_schema='snapshots',
        unique_key='account_id',

        strategy='timestamp',

        updated_at='source_updated_at'
    )
}}

select *

from {{ ref('stg_accounts') }}

{% endsnapshot %}
{% snapshot snap_customers %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',

        strategy='timestamp',

        updated_at='source_updated_at'
    )
}}

select *

from {{ ref('stg_customers') }}

{% endsnapshot %}
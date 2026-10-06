select
    f.transaction_id
from {{ ref('fact_transactions') }} f
join {{ ref('dim_account') }} a
    on f.account_id = a.account_id
where f.customer_id <> a.customer_id
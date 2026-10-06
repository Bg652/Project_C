select *
from {{ ref('fact_transactions') }}
where transaction_status = 'SUCCESS'
  and transaction_amount < 0
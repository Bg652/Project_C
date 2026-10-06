select *
from {{ ref('dim_loan') }}
where outstanding_amount > sanctioned_amount
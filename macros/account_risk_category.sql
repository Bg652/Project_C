{% macro account_risk_category(balance) %}

case

    when {{ balance }} < 0 then 'HIGH_RISK'

    when {{ balance }} < 1000 then 'MEDIUM_RISK'

    else 'LOW_RISK'

end

{% endmacro %}
{% macro classify_transaction(amount) %}

case

    when {{ amount }} >= 100000 then 'HIGH_VALUE'

    when {{ amount }} >= 10000 then 'MEDIUM_VALUE'

    else 'LOW_VALUE'

end

{% endmacro %}  
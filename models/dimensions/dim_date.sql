{{ config(materialized='table') }}

with dates as (

    select date_day

    from unnest(
        generate_date_array(
            '2020-01-01',
            '2035-12-31',
            interval 1 day
        )
    ) as date_day

)

select

    date_day as date_key,

    extract(year from date_day) as year,

    extract(quarter from date_day) as quarter,

    extract(month from date_day) as month,

    extract(day from date_day) as day,

    format_date('%A', date_day) as day_name,

    format_date('%B', date_day) as month_name

from dates
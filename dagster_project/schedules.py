from dagster import ScheduleDefinition

from jobs import banksphere_dbt_pipeline


daily_schedule = ScheduleDefinition(
    job=banksphere_dbt_pipeline,
    cron_schedule="0 2 * * *"
)
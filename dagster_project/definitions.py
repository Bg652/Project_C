from dagster import Definitions

from jobs import banksphere_dbt_pipeline
from schedules import daily_schedule


defs = Definitions(
    jobs=[banksphere_dbt_pipeline],
    schedules=[daily_schedule]
)
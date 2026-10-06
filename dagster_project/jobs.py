from dagster import op, job
import subprocess


@op
def dbt_seed():
    subprocess.run(["dbt", "seed"], check=True)


@op
def dbt_run():
    subprocess.run(["dbt", "run"], check=True)


@op
def dbt_test():
    subprocess.run(["dbt", "test"], check=True)


@op
def dbt_snapshot():
    subprocess.run(["dbt", "snapshot"], check=True)


@job
def banksphere_dbt_pipeline():

    seed = dbt_seed()

    run = dbt_run()

    test = dbt_test()

    snapshot = dbt_snapshot()

    seed
    run
    test
    snapshot
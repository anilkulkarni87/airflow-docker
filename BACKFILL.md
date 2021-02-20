# Understanding Backfill in Airflow

- Please refer the Dag [BACKFILL DAG](./dags/testBackfill.py)
- If the Dag is turned on, the dag runs for the past will scheduled as I have provided catchup a True.
- But if i issue the below command for backfill without turning on thr DAG, many of the tasks fail and I dont see any logs for them as well. 
- Need further investifation

```
airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19
```


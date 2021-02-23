# Understanding Backfill in Airflow

- Please refer the Dag [BACKFILL DAG](./dags/testBackfill.py)
- If the Dag is turned on, the dag runs for the past will be scheduled as I have provided catchup as True.
- ~~But if i issue the below command for backfill without turning on thr DAG, many of the tasks fail and I dont see any logs for them as well.~~
- Update: All the below commands seem to work fine.  

```
airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19

airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19 --delay-on-limit 10 -v --rerun-failed-tasks

airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19 --delay-on-limit 100 -v
```

Output from cli for ssuccessful execution :

`
default@aca6f07e3e5b:/opt/airflow$ airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19 -v
/home/airflow/.local/lib/python3.8/site-packages/airflow/cli/commands/dag_command.py:60 PendingDeprecationWarning: --ignore-first-depends-on-past is deprecated as the value is always set to True
[2021-02-22 02:34:12,439] {dagbag.py:448} INFO - Filling up the DagBag from /opt/airflow/dags
[2021-02-22 02:34:13,150] {base.py:65} INFO - Using connection to: id: postgres_new. Host: postgres, Port: 5432, Schema: airflow, Login: airflow, Password: XXXXXXXX, extra: None
[2021-02-22 02:34:13,245] {base.py:65} INFO - Using connection to: id: postgres_new. Host: postgres, Port: 5432, Schema: airflow, Login: airflow, Password: XXXXXXXX, extra: None
[2021-02-22 02:34:18,823] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-11T00:00:00+00:00: backfill__2021-02-11T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,835] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-12T00:00:00+00:00: backfill__2021-02-12T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,858] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-13T00:00:00+00:00: backfill__2021-02-13T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,867] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-14T00:00:00+00:00: backfill__2021-02-14T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,892] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-15T00:00:00+00:00: backfill__2021-02-15T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,909] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-16T00:00:00+00:00: backfill__2021-02-16T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,940] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-17T00:00:00+00:00: backfill__2021-02-17T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,962] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-18T00:00:00+00:00: backfill__2021-02-18T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,987] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-19T00:00:00+00:00: backfill__2021-02-19T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:34:18,998] {backfill_job.py:377} INFO - [backfill progress] | finished run 9 of 9 | tasks waiting: 0 | succeeded: 9 | running: 0 | failed: 0 | skipped: 0 | deadlocked: 0 | not ready: 0
[2021-02-22 02:34:19,083] {backfill_job.py:830} INFO - Backfill done. Exiting.
`

Logs when the backfill tasks were erroing out:

airflow dags backfill TEST_BACKFILL_DAG --start-date 2021-02-11 --end-date 2021-02-19 --delay-on-limit 10 -v
/home/airflow/.local/lib/python3.8/site-packages/airflow/cli/commands/dag_command.py:60 PendingDeprecationWarning: --ignore-first-depends-on-past is deprecated as the value is always set to True
[2021-02-22 02:20:37,461] {dagbag.py:448} INFO - Filling up the DagBag from /opt/airflow/dags
[2021-02-22 02:20:38,055] {base.py:65} INFO - Using connection to: id: postgres_new. Host: postgres, Port: 5432, Schema: airflow, Login: airflow, Password: XXXXXXXX, extra: None
[2021-02-22 02:20:38,136] {base.py:65} INFO - Using connection to: id: postgres_new. Host: postgres, Port: 5432, Schema: airflow, Login: airflow, Password: XXXXXXXX, extra: None
[2021-02-22 02:20:40,762] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-11 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:40,816] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-12 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:40,873] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-13 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:40,976] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-15 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:41,028] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-16 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:41,084] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-17 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:41,148] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-18 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:41,209] {backfill_job.py:477} ERROR - Task instance <TaskInstance: TEST_BACKFILL_DAG.also_run_this 2021-02-19 00:00:00+00:00 [failed]> with state failed
[2021-02-22 02:20:45,086] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-11T00:00:00+00:00: backfill__2021-02-11T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,102] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-12T00:00:00+00:00: backfill__2021-02-12T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,118] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-13T00:00:00+00:00: backfill__2021-02-13T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,145] {dagrun.py:445} INFO - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-14T00:00:00+00:00: backfill__2021-02-14T00:00:00+00:00, externally triggered: False> successful
[2021-02-22 02:20:45,174] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-15T00:00:00+00:00: backfill__2021-02-15T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,195] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-16T00:00:00+00:00: backfill__2021-02-16T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,214] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-17T00:00:00+00:00: backfill__2021-02-17T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,236] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-18T00:00:00+00:00: backfill__2021-02-18T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,268] {dagrun.py:430} ERROR - Marking run <DagRun TEST_BACKFILL_DAG @ 2021-02-19T00:00:00+00:00: backfill__2021-02-19T00:00:00+00:00, externally triggered: False> failed
[2021-02-22 02:20:45,283] {backfill_job.py:377} INFO - [backfill progress] | finished run 9 of 9 | tasks waiting: 0 | succeeded: 1 | running: 0 | failed: 8 | skipped: 0 | deadlocked: 0 | not ready: 0
Traceback (most recent call last):
  File "/home/airflow/.local/bin/airflow", line 8, in <module>
    sys.exit(main())
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/__main__.py", line 40, in main
    args.func(args)
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/cli/cli_parser.py", line 48, in command
    return func(*args, **kwargs)
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/utils/cli.py", line 89, in wrapper
    return f(*args, **kwargs)
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/cli/commands/dag_command.py", line 103, in dag_backfill
    dag.run(
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/models/dag.py", line 1706, in run
    job.run()
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/jobs/base_job.py", line 237, in run
    self._execute()
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/utils/session.py", line 65, in wrapper
    return func(*args, session=session, **kwargs)
  File "/home/airflow/.local/lib/python3.8/site-packages/airflow/jobs/backfill_job.py", line 811, in _execute
    raise BackfillUnfinished(err, ti_status)
airflow.exceptions.BackfillUnfinished: Some task instances failed:
```
DAG ID             Task ID        Execution date               Try number
-----------------  -------------  -------------------------  ------------
TEST_BACKFILL_DAG  also_run_this  2021-02-11 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-12 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-13 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-15 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-16 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-17 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-18 00:00:00+00:00             1
TEST_BACKFILL_DAG  also_run_this  2021-02-19 00:00:00+00:00             1
```


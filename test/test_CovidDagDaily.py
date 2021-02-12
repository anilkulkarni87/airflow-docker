import unittest
from airflow.models import DagBag


class TestCovidDag(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.dagbag = DagBag()

    def test_import_dags(self):
        self.assertFalse(
            len(self.dagbag.import_errors),
            'DAG import failures. Errors: {}'.format(
                self.dagbag.import_errors
            )
        )

    # def test_alert_email_present(self):
    #     for dag_id, dag in self.dagbag.dags.items():
    #         emails = dag.default_args.get('email', [])
    #         msg = 'Alert email not set for DAG {id}'.format(id=dag_id)
    #         self.assertIn('alert.email@gmail.com', emails, msg)

    def test_task_count(self):
        """Check task count of LOAD_NY_COVID_DLY dag"""
        dag_id = 'LOAD_NY_COVID_DLY'
        dag = self.dagbag.get_dag(dag_id)
        self.assertEqual(len(dag.tasks), 3)

    def test_contain_tasks(self):
        """Check task contains in LOAD_NY_COVID_DLY dag"""
        dag_id = 'LOAD_NY_COVID_DLY'
        dag = self.dagbag.get_dag(dag_id)
        tasks = dag.tasks
        task_ids = list(map(lambda task: task.task_id, tasks))
        self.assertListEqual(
            task_ids, ['getTodayDate', 'get_ny_covid_data_by_date', 'loaddata'])

    def test_dependencies_of_gettodaydate_task(self):
        """Check the task dependencies of getTodayDate in LOAD_NY_COVID_DLY dag"""
        dag_id = 'LOAD_NY_COVID_DLY'
        dag = self.dagbag.get_dag(dag_id)
        dummy_task = dag.get_task('getTodayDate')

        upstream_task_ids = list(
            map(lambda task: task.task_id, dummy_task.upstream_list))
        self.assertListEqual(upstream_task_ids, [])
        downstream_task_ids = list(
            map(lambda task: task.task_id, dummy_task.downstream_list))
        self.assertListEqual(downstream_task_ids, [
                             'get_ny_covid_data_by_date'])

    def test_dependencies_of_loaddata_task(self):
        """Check the task dependencies of hello_task in loaddata dag"""
        dag_id = 'LOAD_NY_COVID_DLY'
        dag = self.dagbag.get_dag(dag_id)
        hello_task = dag.get_task('loaddata')

        upstream_task_ids = list(
            map(lambda task: task.task_id, hello_task.upstream_list))
        self.assertListEqual(upstream_task_ids, ['get_ny_covid_data_by_date'])
        downstream_task_ids = list(
            map(lambda task: task.task_id, hello_task.downstream_list))
        self.assertListEqual(downstream_task_ids, [])

    def test_dag_loaded(self):
        dag = self.dagbag.get_dag(dag_id="LOAD_NY_COVID_DLY")
        assert self.dagbag.import_errors == {}
        assert dag is not None
        assert len(dag.tasks) == 3


if __name__ == '__main__':
    unittest.main()
#suite = unittest.TestLoader().loadTestsFromTestCase(TestCovidDag)
# unittest.TextTestRunner(verbosity=2).run(suite)

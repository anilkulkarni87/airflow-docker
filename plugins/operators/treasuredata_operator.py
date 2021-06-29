from typing import Any

from airflow.models.baseoperator import BaseOperator
from tdclient import api


class treasureDataOperator(BaseOperator):

    def __init__(self,
                 tdapi: str,
                 tdaccount: str,
                 database: str,
                 table: str,
                 **kwargs) -> None:
        super().__init__(**kwargs)
        self.tdapi = tdapi
        self.tdaccount = tdaccount
        self.database = database
        self.table = table

    def execute(self, context: Any) -> bool:
        self.log.info("Creating client")
        conn = api.API(apikey=self.tdapi, endpoint=self.tdaccount)
        return conn.create_log_table(db=self.database, table=self.table)

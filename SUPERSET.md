# Experiements with Apache Superset

I have added Superset to the existing Airflow stack in Docker-compose and there i have been able to visualize the data thats been ingested via airflow DAGS. 

## Instructions to setup Superset

Once the instructions to start Airflow is complete, follow the below steps:
- Connect to the superset container. 
```
docker exec -it airflowdocker_superset_1 /bin/bash
```
- Create user in superset
```
superset fab create-admin --username admin --firstname superset --lastname Admin --email admin@superset.com --password XXXX
```
- Upgrade superset db
```
superset db upgrade
```

- Superset init
```
superset init
```

- Access superset ui at localhost:8090 and login using credentials set above

- Add Database connection. Connection string would be as below:
```
postgresql://airflow:XXXXXXXXXX@postgres:5432/userdata
```


## TODO
- Create a script for the above steps and automate user creation in superset

# Experiements with Apache Superset

I have added Superset to the existing Airflow stack in Docker-compose and there i have been able to visualize the data thats been ingested via airflow DAGS. 
Here is a simple chart that I created
This chart provides the total tests done in Albany county per day and the new positives identified that day. 

![covid-master-2021-02-23T01-43-21 230Z](https://user-images.githubusercontent.com/10644132/108793206-ddd05080-7537-11eb-9297-b4f761372982.jpg)


## Instructions to setup Superset

Once the instructions to start Airflow is complete, follow the below steps:
- Connect to the superset container. 
```
docker exec -it airflow-docker-superset-1 /bin/bash
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
postgresql://airflow:XXXXXXXXXX@host.docker.internal:5433/userdata
```
When you create a connection the host should be : host.docker.internal

![connect_details](https://github.com/anilkulkarni87/airflow-docker/assets/10644132/c9af3af1-2442-4fab-9946-7bdd15ea5ab5.png)
![image](https://user-images.githubusercontent.com/10644132/108793463-6d75ff00-7538-11eb-8b23-c0c9ffa86358.png)


## TODO
- Create a script for the above steps and automate user creation in superset

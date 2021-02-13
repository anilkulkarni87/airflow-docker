<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://cwiki.apache.org/confluence/download/attachments/145723561/airflow_white_bg.png?api=v2" alt="Project logo"></a>
</p>

<h3 align="center">Get covid testing data from NY Health API and persist in Postgres</h3>

## 📝 Table of Contents

- [About](#about)
- [Objective](#objective)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Airflow DAG details](#dag)
- [Airflow and other Concepts Used](#concepts)
- [Airflow Unit Tests](#unittest)
- [TODO](#Todo)
- [Authors](#authors)

## 🧐 About <a name = "about"></a>
Two dags named NY_COVID_INITIAL_LD and LOAD_NY_COVID_DLY will help us get historical and ongoing daily loads from New York Covid testing data.

## 🧐 Objective <a name = "objective"></a>
The objective here is to get NY Covid testing data for all counties and persist the data in a database. Each county to have its own table. The task should execute at a specific time everyday and populate the tables.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

Clone this repo to your machine and follow the instructions under [Usage](#usage)


## 🎈 Usage <a name="usage"></a>

A step by step series of examples that tell you how to get a development env running.

- Clone the Repo

```
git clone
```

- Start docker build

```
docker-compose -f docker-compose.yaml up airflow-init
docker-compose -f docker-compose.yaml up
```

- Keep checking docker processes to make sure all machines are helthy

```
docker ps
```

- Once you notice that all containers are healthy. Access Airflow UI

```
http://localhost:8080
```

- ~~Edit the postgres_default connection from the UI or through command line if you want to persist data in postgres as part of the dags you create. Even better you can always add a new connection.~~ 

        Update: Ignore this step as this has now been accommodated in the new docker compose yaml


```
  ./airflow.sh bash 

  airflow connections add 'postgres_new' --conn-uri 'postgres://airflow:airflow@postgres:5432/airflow'

  connect to postgres and create new database with name 'userdata'

  ```

## 🎈 Airflow DAG Details <a name="dag"></a>

*   Activate the DAG NY_COVID_INITIAL_LD. What does it do?
    *   Created tables for all 62 counties in New York in Postgres under database userdata.
    *   Creates function and trigger in postgres to auto-populate the all the 62 counties with their data.
    *   Makes a call to NY Health API and gets data in json.
    *   Loads this json data to Postgres table.

*   The next day activate the Dag : LOAD_NY_COVID_DLY. What does it do?
    *   Gets execution date from Airflow context
    *   Calls the NY Helath API with that date and saves result in json.
    *   Loads this data to Postgres table.

## Airflow and other Concepts Used <a name = "concepts"></a>

*   TaskGroups
    *   To create all the county tables
*   Task Flow Api
    *   Using Task Flow with classic operators.
    *   Adding task retires with Task Flow style dag definition
*   Airflow Macros
    *   To get the execution date in the Daily DAG.
    * Used in conjunction with TaskFlow API.
*   Postgres psql function
    *   To populate child tables when master table is populated. 
*   Airflow Unit Tests
*   Create multiple databases in postgres as part of docker compose.

## Airflow UnitTests <a name = "unittest"></a>
Unit test for airflow dags has been defined and present in the test folder. This folder is also mapped to the docker containers inside the docker-compose.yaml file.
Follow below steps to execute unittests after the docker containers are running:
```
./airflow bash

python -m unittest discover -v
```
![image](https://user-images.githubusercontent.com/10644132/107426407-0aff1680-6ad5-11eb-9b1e-1a677ef78ab5.png)

## ✍️ ToDo <a name = "Todo"></a> 
*   The Objective can be achieved by just one daily dag and using backfill and catchup.
*   Explore the new rest Api of Airflow
    *   Maybe implement rest api test framework using RestAssured :)
*   Implement Audit jobs or explore greatexpectations operator.
*   Implement Unit testing for the Dags and operators.


## ✍️ Authors <a name = "authors"></a>

- [@anilkulkarni87](https://github.com/anilkulkarni87)
  

<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://cwiki.apache.org/confluence/download/attachments/145723561/airflow_white_bg.png?api=v2" alt="Project logo"></a>
</p>

<h3 align="center">Airflow Made Easy | Local Setup Using Docker</h3>



[![Execute Airflow Unit Tests](https://github.com/anilkulkarni87/airflow-docker/actions/workflows/main.yml/badge.svg)](https://github.com/anilkulkarni87/airflow-docker/actions/workflows/main.yml)

[![Deploy GitHub Pages](https://github.com/anilkulkarni87/airflow-docker/actions/workflows/jekyll-gh-pages.yml/badge.svg)](https://github.com/anilkulkarni87/airflow-docker/actions/workflows/jekyll-gh-pages.yml)

<p align="center"> This is my Apache Airflow Local development setup using docker-compose. It will also include some sample DAGs and workflows.
    <br> 
</p>

#### Recent Updates:
03-Dec-2023
- Upgrade to airflow 2.7.3
- Upgraded superset to add secret key
- Added superset database connection image
- Works on M1 Mac

03-May-2022
- Added Dockerfile to extend airflow image
- Adding additional Pypi package (td-client)
- Upgrade to Airflow 2.3.0

29-Jun-2021
- Updated image to Airflow 2.1.1
- Leveraging _PIP_ADDITIONAL_REQUIREMENTS to install additional dependencies
- Developing and testing operators for Treasure Data
- Read more at [Treasure Data](./TreasureData.md)

## 📝 Table of Contents

- [About](#about)
- [Data Engineering Projects](#projects)
- [Data Visualization](#superset)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Running the tests](#tests)
- [Github Workflow](#githubworkflow)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)
- [Cleanup](#cleanup)

## 🧐 About <a name = "about"></a>

Setup Apache Airflow 2.0 locally on Windows 10 (WSL2) via Docker Compose. The oiginal docker-compose.yaml file was taken from the official [github](#https://github.com/apache/airflow/blob/master/docs/apache-airflow/start/docker-compose.yaml) repo. 

This contains service definitions for
- airflow-scheduler
- airflow-webserver
- airflow-worker
- airflow-init - To initialize db and create user
- flower
- redis
- postgres - This is backend for airflow. I am also creating additional database `userdata` as a backend for my data flow. This is not recommended. Its ideal to have separate databases for airflow and your data.

I have added additional command to add a airflow db connection as part of the docker-compose

Directories I am mounting:
- ./dags
- ./logs
- ./plugins
- ./sql - for Sql files. We can leveraje jinja templating in our queries. Refer the sample Dag.
- ./test - Has Unit tests for Airflow Dags.
- ./pg-init-scripts - This has scripts to create additional database in postgres.

## Data Engineering Projects <a name = "projects"></a>
Here you will find some personal projects that I have worked on. These projects will throw light on some of the airflow features I have used and learnings related to other technologies. 
- Project 1 -> [Get Covid testing data](./COVID_NY.md)

## Data Visualization <a name = "superset"></a>
To experiment with Apache Superset. Read more [here](./SUPERSET.md)

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

Clone this repo to your machine

```
docker-compose -f docker-compose.yaml up airflow-init
docker-compose -f docker-compose.yaml up
```

### Prerequisites

What things you need to install the software and how to install them.

You should have [Docker](#https://docs.docker.com/engine/installation/) and [Docker-compose](#https://docs.docker.com/compose/install/) v1.27.0 or more installed on your machine

- Install and configure [WSL2](#https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers)
- I also had to reset my Ubuntu installation and thats when it asked me to create a user. 

### Installing

A step by step series of examples that tell you how to get a development env running.

Clone the Repo

```
git clone
```

Start docker build

```
#To extend airflow image
docker-compose build

docker-compose -f docker-compose.yaml up airflow-init

docker-compose -f docker-compose.yaml up
```

Keep checking docker processes to make sure all machines are helthy

```
docker ps
```

Once you notice that all containers are healthy. 

Add a connection to Postgres via command line and then Access Airflow UI

```
docker exec -it airflow-docker_airflow-worker airflow connections add 'postgres_new' --conn-uri 'postgres://airflow:airflow@postgres:5432/airflow'
```

```
http://localhost:8080
```


End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>

Unit test for airflow dags has been defined and present in the `test` folder. This folder is also mapped to the docker containers inside the docker-compose.yaml file.
Follow below steps to execute unittests after the docker containers are running:
```
./airflow bash
python -m unittest discover -v
```

### Github Workflow for running tests <a name="githubworkflow"></a>
I had to create another docker-compose to be able to execute unit tests whenever I push code to master. 
Please refer
- [Docker Compose for github workflow](./docker-compose-githubworkflow.yaml)
- [Workflow Yaml file](./.github/workflows/main.yml)


### Break down into end to end tests

Another #TODO

## 🎈 Usage <a name="usage"></a>

Now you can create new dags and place them in your local system and can see it coming live on web UI. Refer the sample dag in the repo. 

  ### ~~Important~~ : 
  ~~Edit the postgres_default connection from the UI or through command line if you want to persist data in postgres as part of the dags you create. Even better you can always add a new connection.~~

    Update: This is now taken care of the in the updated Docker compose file. The connection and the new database are created

  ```
  ./airflow.sh bash

  airflow connections add 'postgres_new' --conn-uri 'postgres://airflow:airflow@postgres:5432/airflow'

  connect to postgres and create new database with name 'userdata'

  ```
  docker exec -it airflowdocker_postgres_1 /bin/bash
  psql -U airflow
  create database userdata;
  ```

  Turn on Dag: PostgreOperatorTest_Dag
  ```

## ⛏️ Built Using <a name = "built_using"></a>

- [Postgres](https://www.postgresql.org/) - Database
- [Redis](https://redis.io/) 
- [Apache Airflow](https://airflow.apache.org/) 
- [Docker](https://www.docker.com/) - build Tool
- [Apache Superset](https://superset.apache.org/) - For Data visualization

## ✍️ Authors <a name = "authors"></a>

- The Airflow community
- [@anilkulkarni87](https://github.com/anilkulkarni87) 

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [Apache Airflow](#https://github.com/apache/airflow/blob/master/docs/apache-airflow/start/docker-compose.yaml)
- Inspiration is the Airflow Community

## Cleanup <a name = "cleanup"></a>

```
docker-compose down --volumes --rmi all
```

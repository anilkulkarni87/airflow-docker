<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://cwiki.apache.org/confluence/download/attachments/145723561/airflow_white_bg.png?api=v2" alt="Project logo"></a>
</p>

<h3 align="center">Apache Airflow 2.0 with Docker on Windows 10 | WSL2</h3>

<div align="center">

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> This is my Apache Airflow Local development setup on Windows 10 WSL2 using docker-compose. It will also include some sample DAGs and workflows.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

Setup Apache Airflow 2.0 locally on Windows 10 (WSL2) via Docker Compose. The oiginal docker-compose.yaml file was taken from the official [github](#https://github.com/apache/airflow/blob/master/docs/apache-airflow/start/docker-compose.yaml) repo. 

This contains service definitions for
- airflow-scheduler
- airflow-webserver
- airflow-worker
- airflow-init-db - To initialize db
- airflow-init-user - To create airflow user.
- flower
- redis

I had to split the `airflow-init` in the original yaml to two separate steps to make this successful in Windows 10 WSL2.

Directories I am mounting:
- ./dags
- ./logs
- ./plugins
- ./sql - for Sql files. We can leveraje jinja templating in our queries. Refer the sample Dag.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

Clone this repo to your machine

```
docker-compose up --detach
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
docker-compose up --detached
```

Keep checking docker processes to make sure all machines are helthy

```
docker ps
```

Once you notice that all containers are healthy. Access Airflow UI

```
http://localhost:8080
```

End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>

This is #TODO

### Break down into end to end tests

Another #TODO

## 🎈 Usage <a name="usage"></a>

Now you can create new dags and place them in your local system and can see it coming live on web UI. Refer the sample dag in the repo. 

  ### Important : 
  Edit the postgres_default connection from the UI or through command line if you want to persist data in postgres as part of the dags you create. Even better you can always add a new connection. 

  ```
  ./airflow.sh bash 

  airflow connections add 'postgres_new' --conn-uri 'postgres://airflow:airflow@postgres:5432/airflow'

  connect to postgres and create new database with name 'userdata'

  Turn on Dag: PostgreOperatorTest_Dag
  ```

## ⛏️ Built Using <a name = "built_using"></a>

- [Postgres](https://www.postgresql.org/) - Database
- [Redis](https://redis.io/) 
- [Apache Airflow](https://airflow.apache.org/) 
- [Docker](https://www.docker.com/) - build Tool

## ✍️ Authors <a name = "authors"></a>

- The Airflow community
- [@anilkulkarni87](https://github.com/anilkulkarni87) 

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [Apache Airflow](#https://github.com/apache/airflow/blob/master/docs/apache-airflow/start/docker-compose.yaml)
- Inspiration is the Airflow Community
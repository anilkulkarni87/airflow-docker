setup:
	docker-compose up -f docker-compose-githubworkflow.yaml airflow-init
	docker-compose up -f docker-compose-githubworkflow.yaml -d
	sleep 240

down:
	docker-compose down

testing:
	docker ps -a
	docker exec airflow-worker python -m unittest discover -v
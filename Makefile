setup:
	docker-compose -f docker-compose-githubworkflow.yaml up airflow-init
	docker-compose -f docker-compose-githubworkflow.yaml up -d
	sleep 240

down:
	docker-compose down

testing:
	docker ps -a
	docker exec airflow-worker python -m unittest discover -v
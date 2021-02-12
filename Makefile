setup:
	docker-compose -f docker-compose-githubworkflow.yaml up airflow-init
	docker-compose -f docker-compose-githubworkflow.yaml up -d
	sleep 240
	docker ps -a

down:
	docker-compose down

testing:
	docker exec airflow-worker python -m unittest discover -v
setup:
	docker-compose up airflow-init
	sleep 240
	docker-compose up

down:
	docker-compose down

testing:
	docker exec airflow-worker python -m unittest discover -v
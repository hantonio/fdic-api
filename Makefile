help:   ## Show this help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

all:     build up ## Build application container and start both app and db

build:  ## Build application container
	docker-compose build

up:	 updb initdb upapp ## Start both app and db containers in detached mode
	
down:   ## Stop both app and db containers
	docker-compose stop

drop:   ## Drop everything
	docker-compose down -v

test:   ## Trigger newman to test the API
	newman run 'postman/FDIC-API.postman_collection.json' -e 'postman/FDIC-API_LOCALHOST.postman_environment.json' --timeout-request 5000

updb:   ## Start only db container in detached mode
	@echo "Starting CouchDB container..."
	#docker run -d --restart always --hostname localhost --name couchdb -p 5984:5984 -e COUCHDB_USER=couchdbadmin -e COUCHDB_PASSWORD=couchdbadmin -v couchdb-data:/opt/couchdb/data couchdb
	docker-compose up -d couchdb

downdb: ## Stop only db container
	@echo "Stopping CouchDB container..."
	#docker stop couchdb
	docker-compose stop couchdb

initdb: ## Initialize DB with FDIC data
	sleep 10
	@echo "Create fdic_institutions2 database..."
	curl -X PUT http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2
	@echo "Retrieve INSTITUTIONS2.json..."
	curl -k -o data/INSTITUTIONS2.json https://raw.githubusercontent.com/remkohdev/fdic-api/master/data/INSTITUTIONS2.json
	@echo "Bulk insert JSON to populate CouchDB..."
	curl -X POST -H "Content-Type: application/json" "http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_bulk_docs" -d '@data/INSTITUTIONS2.json'
	./create-views.sh

dropdb: ## Drop db container and its data volume
	@echo "Removing CouchDB container..."
	#docker rm couchdb
	docker-compose rm couchdb
	@echo "Dropping data volume..."
	#docker volume rm couchdb-data

upapp:  ## Start only app container in detached mode
	#docker run -d --restart always --name fdic-api -p 3000:3000 -e "NODE_ENV=local" fdic-api
	docker-compose up -d app

downapp:## Stop only app container
	#docker stop fdic-api
	docker-compose stop app

dropapp:## Drop app container
	#docker rm fdic-api
	docker-compose rm app


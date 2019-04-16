# fdic-api

This is an implementation of FDIC api available at the following Medium article:
https://medium.com/nycdev/agile-and-test-driven-development-tdd-with-swagger-docker-github-postman-newman-and-jenkins-347bd11d5069

Added a Makefile and structured the project to use docker-compose to build containers and start database and application respectively. It can be easily integrated with a Jenkins pipeline to build and test the application.

# Requisites

```sh
$ cd src
$ npm install --save util
$ npm install --save loopback-datasource-juggler
$ npm install --save loopback-connector-couchdb2
$ npm install --save lodash
$ npm install --save newman
```
*Depending on the way NPM is installed, it will need sudo to install the libraries.*

## Using Makefile

Makefile is an easy way to build and control the application using Docker and docker-compose.

```sh
$ make help
help:    Show this help message
all:     build up  Build application container and start both app and db
build:   Build application container
up:	 updb initdb upapp  Start both app and db containers in detached mode
down:    Stop both app and db containers
drop:    Drop everything
test:    Trigger newman to test the API
updb:    Start only db container in detached mode
downdb:  Stop only db container
initdb:  Initialize DB with FDIC data
dropdb:  Drop db container and its data volume
upapp:   Start only app container in detached mode
downapp: Stop only app container
dropapp: Drop app container
```

# rederly
* This repo is intended to be a parent directory for all of the components of rederly for easier clone and setup
* Currently this repo is only used for tracking documents and resources (i.e. nginx configurations on the server)

## Building Rederly for local dev using docker

### dependencies 
Ensure you cloned the backend and scheudler repo into your local enviroment and each service has a dockerfile.dev

### development

This will spin up and run all compenents of rederly as defined by the docker-compose file: 

* redis
* backend web service
* scheduler web service
* postgres


```bash
cd docker-dev
docker-compose build 
docker-compose up
```

To access the backend and scheudler containers run the following after docker-compose finishes:

```bash
docker exec -it dev-backend /bin/sh
docker exec -it dev-scheduler /bin/bash
```


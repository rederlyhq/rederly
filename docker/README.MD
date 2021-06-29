# Proxy
Add `rederly_proxy` to host file. This is because some things (like auto submit and email locations) depend on requesting url.  
Instructions for editing host file is located here: https://docs.rackspace.com/support/how-to/modify-your-hosts-file/  
On unix based systems this is located at `/etc/hosts`  
On windows this file is located at `c:\Windows\System32\Drivers\etc\hosts`  
Added this line: `127.0.0.1 rederly_proxy`

# Backend
## Initialize Database from backend
Since the db is running but not ready at startup you should not run with `DB_SYNC=true`.  

To initialize the database:
```bash
# First you should start up the system
docker-compose up

# Reset the database
# docker exec -it -e PGPASSWORD='password' -e PGUSER="postgres" rederly_db dropdb "rederly"

# Initialize the database
docker exec -it -e PGPASSWORD='password' -e PGUSER="postgres" rederly_db createdb "rederly"
# Have the backend initialize db schema
docker exec -it -e DB_SYNC=true rederly_backend npm run cli:built noop
# Have the backend generate migration table (this will fail if you are running on initial database)
docker exec -it rederly_backend npm run sequelize:built:migrations
# Restore static data (see details in `Backup static data`)
cat resources/initialData.sql | docker exec -i -e PGPASSWORD='password' -e PGUSER="postgres" -e PGDATABASE="rederly" rederly_db psql
# Create a university (file may need modification)
cat resources/university.sql | docker exec -i -e PGPASSWORD='password' -e PGUSER="postgres" -e PGDATABASE="rederly" rederly_db psql
# Create blank curriculum (if you want that)
cat resources/curriculum.sql | docker exec -i -e PGPASSWORD='password' -e PGUSER="postgres" -e PGDATABASE="rederly" rederly_db psql
```

## Backup static data
I set the following environment variables and then ran the below command
* PGHOST
* PGPASSWORD
* PGUSER
* PGDATABASE
* PGPORT
```bash
pg_dump -a -x -Fp -O -t '"SequelizeMeta"' -t 'topic_type' -t 'permission' > resources/initialData.sql
```

## Migrations
To run the database migrations use the below command after `docker-compose up`
```bash
docker exec -it rederly_backend npm run sequelize:built:migrations
```

# Library Browser
To set up the database:
```bash
# First you should start up the system
docker-compose up

# Reset the database
# docker exec -it -e PGPASSWORD='password' -e PGUSER="postgres" rederly_db dropdb "opl"

# Initialize the database
docker exec -it -e PGPASSWORD='password' -e PGUSER="postgres" rederly_db createdb "opl"
# Restore static data (see details in `Backup static data`)
cat ../source/library-browser/resources/opl-data.psql.backup | docker exec -i -e PGPASSWORD='password' -e PGUSER="postgres" rederly_db pg_restore -x -Fc -O -d "opl"
```

# AWS Mocking
We are using localstack to mock out aws services.
https://gist.github.com/crypticmind/c75db15fd774fe8f53282c3ccbe3d7ad
## Tools
https://github.com/localstack/awscli-local
```bash
pip install awscli-local
```

## Attachments
```
./aws-setup.sh
# Copy the url from there and put it in the backend config file
# Restart backend, which requires everything that talks to it to be restared -- todo fix and make aws mocks peristent
docker restart rederly_backend
```

# Known issues with local run
For some reason localstack is dropping /exports, so when you do a build pdfs and hit download you need to prefix exports to the base url.
Example: `http://rederly_proxy:3000/6f204bc3-d3e2-47f0-8450-83a4a5c0f453/2/2_1624984616964-solutions.zip` ==> `http://rederly_proxy:3000/exports/6f204bc3-d3e2-47f0-8450-83a4a5c0f453/2/2_1624984616964-solutions.zip`
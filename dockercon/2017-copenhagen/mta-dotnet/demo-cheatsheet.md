# Prep

On local machine:

```
drmf
cd C:\scm\github\sixeyed\presentations\dockercon\2017-copenhagen\mta-dotnet
```

On test VM:

```
docker stack rm chat
cd C:\mta-dotnet\app\secrets
docker secret create audit-db.password audit-db.password
docker secret create backbone-db.password backbone-db.password
docker secret create chat-connection-strings chat-connection-strings
cd C:\mta-dotnet\app
```

On UCP:

- join Windows node
- remove stacks
- create secrets


# Demo 1 - build and run locally

Build app in Docker:

```
docker image build -t chat-web -f docker\web\Dockerfile .
```

Run with Docker Compose:

```
cd app

docker-compose up -d
```

Connect to local DB:

```
docker container inspect app_audit-db_1
```

Try app locally:

```
dip app_web-app_1
```

# Demo 2 - ship to DTR

Three issues: db passwords in plaintext, startup time, log files

Build new version:

```
cd ..

docker image build -t chat-web:v2 -f docker\web\Dockerfile.v2 .
```

Tag and push to https://dtr.sixeyed.com

```
docker image tag chat-web:v2 dtr.sixeyed.com/dockercon/chat-web:v2

docker image push dtr.sixeyed.com/dockercon/chat-web:v2
```

# Demo 3 - run (test)

Login to `dceu-test.westeurope.cloudapp.azure.com`.

Swarm mode:

```
docker node ls

docker secret ls
```

Run app:

```
docker stack deploy -c docker-stack-test.yml chat
```

Test app at http://chat-test.sixeyed.com - 2 screens

Verify data:

```
docker container exec -it <id> `
 powershell "Invoke-SqlCmd -Query 'SELECT * FROM ChatAudit' -Database AuditDB"
```

# Demo 4

Run in EE with `docker-stack-prod-v1.yml`.

Check with Sqlectron.

Find issue:

```
Bye!'); DELETE FROM ChatAudit; --
```

Fix issue with `docker-stack-prod-v2.yml`.
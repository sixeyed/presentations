# Prep

On test VM:

```
docker stack rm chat
cd C:\mta-dotnet\app\secrets
docker secret create audit-db.password audit-db.password
docker secret create backbone-db.password backbone-db.password
docker secret create chat-connection-strings chat-connection-strings
```

On UCP:

- join Windows node
- remove stacks

# Demo 1 - build

Build app in Docker:

```
docker image build -t chat-web -f docker\web\Dockerfile .
```

Run with Docker Compose locally:

```
cd app

docker-compose up -d
```

# Demo 2 - ship

Three issues: db passwords in plaintext, startup time, log files

Build new version:

```
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
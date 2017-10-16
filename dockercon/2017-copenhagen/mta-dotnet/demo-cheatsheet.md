# Prep

On local machine:

```
drmf
cd C:\scm\github\sixeyed\presentations\dockercon\2017-copenhagen\mta-dotnet
```

On UCP:

- remove stacks

On Azure:

- add local client IP to SQL DB

# Demo 1 - build and run locally

Build app in Docker:

```
docker image build -t chat-web:v1 -f docker\web\Dockerfile .
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

Three issues: db passwords in plaintext, startup time, log files

```
docker container logs app_web-app_1
```

# Demo 2 - ship to DTR

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

# Demo 3 - run prod

Connect to remote swarm:

```
cd ucp-bundle-elton

. .\env.ps1

docker node ls
```

Run with `docker-stack-prod-v1.yml`:

```
cd ..\app

docker stack deploy -f docker-stack-prod-v1.yml chat
```


Check with Sqlectron.

Find issue:

```
Bye!'); DELETE ChatAudit; --
```

Fix issue with `docker-stack-prod-v2.yml`:

```
docker stack deploy -f docker-stack-prod-v2.yml chat
```

Repeat test - check logs in https://ucp.sixeyed.com
## Prep

Run Docker - switch to Linux containers

```
cd ~/scm/github/sixeyed/presentations/linuxing-in-london/201711-docker-workshop
```

## Demo 1 - run some sample containers

Web server:

```
docker container run --detach --publish 80:80 nginx:alpine
```

Database:

```
docker container run --detach --publish 1433:1433 `
 --env-file db-credentials.env `
 --name signup-db `
 microsoft/mssql-server-linux:2017-CU1
```

## Demo 1 - run some sample containers

Windows:

```
docker container run -it microsoft/windowsservercore powershell
```

IIS:

```
docker container run --detach --publish 8081:80 microsoft/iis:nanoserver
```

SQL Server:

```
cd C:\scm\github\sixeyed\presentations\docker-mumbai\2018-04-docker-windows-beginners-guide

docker container run --detach --publish 1433:1433 `
 --env-file db-credentials.env `
 --name mta-db `
 microsoft/mssql-server-windows-express:2016-sp1
```

## Demo 2 - Build, ship & run

Build:

```
cd C:\scm\github\sixeyed\docker-windows-workshop\part-2\web-1.1

docker image build -t signup-web:1.1 .
```

Ship:

```
docker image tag signup-web:1.1 sixeyed/signup-web:1.1-mumbai

docker image push sixeyed/signup-web:1.1-mumbai
```

Run:

```
docker container run -d -P signup-web:1.1
```

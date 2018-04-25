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
cd C:\scm\github\sixeyed\presentations\great-indian-dev-summit\2018-docker-windows-beginners-guide

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
docker image tag signup-web:1.1 sixeyed/signup-web:1.1-gids18

docker image push sixeyed/signup-web:1.1-gids18
```

Run:

```
docker container run -d -P sixeyed/signup-web:1.1-gids18
```

## Demo 1 - app v1.2

Build from source:

```
cd C:\scm\github\sixeyed\docker-windows-workshop

docker image build `
  --tag sixeyed/signup-web:1.2 `
  --file part-2\web-1.2\Dockerfile .
```

Run:

```
cd app

docker-compose `
  -f docker-compose-1.2.yml `
  up -d 
```


## Demo 3 - app v1.3

> Update SignUp.aspx.cs to publish event

Build:

```
cd C:\scm\github\sixeyed\docker-windows-workshop

docker image build `
  --tag sixeyed/signup-web:1.3 `
  -f part-3\web-1.3\Dockerfile .
```

Run with message queue:

```
cd app

docker-compose `
  -f .\docker-compose-1.3.yml `
  up -d
```

## Demo 3 - analytics

Run with Elasticsearch & Kibana:

```
cd app

docker-compose `
  -f .\docker-compose-1.4.yml `
  up -d
```

## Pre-reqs 

- Create `assets-prod1 db in Azure

## Setup

- Docker
- Powershell
- Sqlectron

```
$env:workshop='C:\scm\github\sixeyed\docker-windows-workshop'
cd $env:workshop
```

## Demo 1 - SQL Server

```
docker container run -d -p 1433:1433 `
 -e ACCEPT_EULA=Y `
 -e SA_PASSWORD=DockerCon!!! `
 --name mssql `
 microsoft/mssql-server-windows-express:2016-sp1
```

Connect. Create db & table & insert data. Query data file location:

```
select * from sys.master_files
```

Exec into container and check data files:

```
docker container exec -it mssql powershell
```

Replace - no data.

```
docker rm -f mssql
```

## Demo 2 - SQL Server with volumes

```
mkdir C:\demo2

docker container run -d -p 1433:1433 `
 -v C:\demo2:C:\data `
 -e ACCEPT_EULA=Y `
 -e SA_PASSWORD=DockerCon!!! `
 --name mssql `
 microsoft/mssql-server-windows-express:2016-sp1
```

Connect, create DB with specific file path - `demo2.sql`

On host, check files:

```
ls C:\demo2
```

Remove container and recreate. Check databases; run `FOR ATTACH` script.

## Demo 3 - Packaging a custom schema

Walk through Dockerfiles.

Run v1:

```
mkdir C:\demo3

docker container run -d -p 1433:1433 `
 -v C:\demo3:C:\data `
 --name assets-db `
 dockersamples/assets-db:v1
```

Wait for startup, check logs, connect & run SQL.

Remove and replace:

```
docker rm -f assets-db

docker container run -d -p 1433:1433 `
 -v C:\demo3:C:\data `
 --name assets-db `
 dockersamples/assets-db:v2
```


## Demo 4 - CI/CD for the database

```
docker container run dockersamples/assets-db:v2 `
 "-TargetServerName 'sc-demo.database.windows.net' -TargetDatabaseName 'assets-prod' -TargetUser 'elton' -TargetPassword 'DockerCon!!!'"
```
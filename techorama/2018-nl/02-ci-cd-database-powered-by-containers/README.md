
## Pre-reqs 

- Create `assets-prod` db in Azure

## Setup

- Docker
- Powershell
- Sqlectron

<<<<<<< HEAD
```
$env:demos='C:\scm\github\sixeyed\presentations\dotnet-developerdays\2018-ci-cd-database-powered-by-containers'
cd $env:demos
```

=======
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
## Demo 1 - SQL Server

```
docker container run -d -p 1433:1433 `
 -e ACCEPT_EULA=Y `
 -e SA_PASSWORD=DockerCon!!! `
 --name mssql `
<<<<<<< HEAD
 microsoft/mssql-server-windows-express:2016-sp1
=======
 microsoft/mssql-server-windows-express:2016-sp1    
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
```

Connect. Create db & table & insert data. Query data file location:

```
<<<<<<< HEAD
select * from sys.master_files
=======
select name, physical_name from sys.master_files
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
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

<<<<<<< HEAD
Remove and replace:
=======
Remove and replace with v1:
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5

```
docker rm -f assets-db

docker container run -d -p 1433:1433 `
 -v C:\demo3:C:\data `
 --name assets-db `
<<<<<<< HEAD
 dockersamples/assets-db:v2
```


=======
 dockersamples/assets-db:v1
```

Remove and replace with v2:

```
docker rm -f assets-db

docker container run -d -p 1433:1433 `
 -v C:\demo3:C:\data `
 --name assets-db `
 dockersamples/assets-db:v2
```

h
>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
## Demo 4 - CI/CD for the database

```
docker container run dockersamples/assets-db:v2 `
 "-TargetServerName 'sc-demo.database.windows.net' -TargetDatabaseName 'assets-prod' -TargetUser 'elton' -TargetPassword 'DockerCon!!!'"
```
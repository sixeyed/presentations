## Prep

Switch Docker to Windows VM.

```
cd C:\scm\github\sixeyed\presentations\developer-south-coast\2018-02-modernizing-dotnet-with-docker
```

## Demo 1 - run some sample containers

Windows:

```
docker container run -it microsoft/windowsservercore
```

IIS:

```
docker container run `
 --detach `
 --publish 8081:80 `
 microsoft/iis:nanoserver
```

Browse to http://devsum18.westeurope.cloudapp.azure.com:8081

SQL Server:

```
docker container run `
 --detach `
 --publish 1433:1433 `
 --env ACCEPT_EULA=Y `
 --env sa_password=DockerCon!!! `
 microsoft/mssql-server-windows-express:2016-sp1
```

Connect SQL client to devsum18.westeurope.cloudapp.azure.com.

Verify process running on host:

```
hostname

Get-Process -Name sql*

Get-Process -Name w3*
```

## Demo 2 - app v1.0

Build with MSI:

```
cd "$env:workshop\part-2\web-1.0"

docker image build --tag sixeyed/signup-web:1.0 .
```

Run:

```
cd "$env:workshop\app"

docker-compose -f docker-compose-1.0.yml up -d
```

Ship:

```
docker image push sixeyed/signup-web:1.0
```

Demo 3 - app v 1.4

```
cd "$env:workshop\app"

docker-compose -f .\docker-compose-1.4.yml up -d
```
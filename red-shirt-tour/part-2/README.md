
# Dockerizing .NET Applications

## App V1

Build V1 using MSI:

```
docker build -t web .
```

Run SQL Server & app:

```
docker run -d --name db -e ACCEPT_EULA=Y --env-file db-credentials.env microsoft/mssql-server-windows-express

docker run -d -P --env-file db-credentials.env web
```

## App V2

Multi-stage builds:

```
docker-compose -f ./app/docker-compose-v2.yml -f ./app/docker-compose-v2.build.yml build
```

Start whole solution:

```
docker-compose -f ./app/docker-compose-v2.yml up -d
```

## App V3

Multi-stage builds:

```
docker-compose -f ./app/docker-compose-v3.yml -f ./app/docker-compose-v3.build.yml build
```

Start whole solution:

```
docker-compose -f ./app/docker-compose-v3.yml up -d
```

## .NET Sample App

ASP.NET 3.5 WebForms app, built from `src` using VS2008, published to directory and zipped as `WebFormsApp.zip`.

### v0 - vanilla

Dockerfile deploys zip file, no integrations with Docker:

```
docker image build -t sixeyed/dcsf-netfx:v0 -f ./v0/Dockerfile .

docker container run -d -p 8080:80 sixeyed/dcsf-netfx:v0
```

### v1 - add logging

Relays app logs to Docker, using startup script:

```
docker image build -t sixeyed/dcsf-netfx:v1 -f ./v1/Dockerfile .

docker container run -d -p 8080:80 `
  -v C:\app-logs:C:\logs `
  sixeyed/dcsf-netfx:v1
```

### v2 - add config

Reads config from Docker, using environment variables for paths:

```
docker image build -t sixeyed/dcsf-netfx:v2 -f ./v2/Dockerfile .
```

Run in swarm mode:

```
docker config create netfx-appsettings .\appSettings.config

docker config create netfx-log4net .\log4net.config

docker service create `
  --name netfx-web `
  --config netfx-appsettings `
  --env APPSETTINGS_CONFIG_PATH=C:\netfx-appsettings `
  --config netfx-log4net `
  --env LOG4NET_CONFIG_PATH=C:\netfx-log4net `
  --publish published=8080,target=80,mode=host `
  sixeyed/dcsf-netfx:v2
```

### v3 - add dependency checks

Uses utility app to check dependencies available for main app.

```
docker image build -t sixeyed/dcsf-netfx:v3 -f ./v3/Dockerfile .
```

Fails if no SQL:

```
docker container run -d -p 8080:80 sixeyed/dcsf-netfx:v3
```

Run in swarm mode with SQL container & secret:

```
docker network create -d overlay netfx

docker service create `
  --name sql-server `
  --env ACCEPT_EULA=Y `
  --env sa_password=DockerCon!!! `
  --network netfx `
  --endpoint-mode dnsrr `
  microsoft/mssql-server-windows-express:2016-sp1  

docker secret create netfx-connectionstrings .\connectionStrings.config

docker service update `
  --secret netfx-connectionstrings `
  --env 'CONNECTIONSTRINGS_CONFIG_PATH=C:\ProgramData\Docker\secrets\netfx-connectionstrings' `
  --image sixeyed/dcsf-netfx:v3 `
  netfx-web
```

### v4 - add healthcheck

Uses utility app to ping website in container.

```
docker image build -t sixeyed/dcsf-netfx:v4 -f ./v4/Dockerfile .
```

Run locally:

```
docker container run -d -p 8080:80 sixeyed/dcsf-netfx:v4
```

Run in swarm mode:

```
docker service update `
  --image sixeyed/dcsf-netfx:v4 `
  netfx-web
```

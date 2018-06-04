
## .NET Sample App

ASP.NET 3.5 WebForms app, built from `src` using VS2008, published to directory and zipped as `WebFormsApp.zip`.

==TODO - add hostname to homepage and db config and write-to-db button==

### v0

Dockerfile deploys zip file, no integrations with Docker:

```
docker image build -t sixeyed/dcsf-netfx:v0 -f ./v0/Dockerfile .

docker container run -d -p 8080:80 sixeyed/dcsf-netfx:v0
```

### v1

Relays app logs to Docker, using startup script:

```
docker image build -t sixeyed/dcsf-netfx:v1 -f ./v1/Dockerfile .

docker container run -d -p 8080:80 `
  -v C:\app-logs:C:\logs `
  sixeyed/dcsf-netfx:v1
```

### v2

Reads config from Docker, using environment variables for paths:

```
docker image build -t sixeyed/dcsf-netfx:v2 -f ./v2/Dockerfile .
```

Run in swarm mode:

```
docker config create netfx-appsettings .\appSettings.config

docker config create netfx-log4net .\log4net.config 

docker service create `
  --config netfx-appsettings `
  --env APPSETTINGS_CONFIG_PATH=C:\netfx-appsettings `
  --config netfx-log4net `
  --env LOG4NET_CONFIG_PATH=C:\netfx-log4net `
  --publish published=8080,target=80,mode=host `
  sixeyed/dcsf-netfx:v2
```
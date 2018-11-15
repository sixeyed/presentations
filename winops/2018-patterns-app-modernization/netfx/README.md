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
```

Deploy:

```
docker stack deploy -c docker-stack-v1.yml netfx
```

### v2 - add config

Reads config from Docker, using environment variables for paths:

```
docker image build -t sixeyed/dcsf-netfx:v2 -f ./v2/Dockerfile .
```

Deploy configs & app:

```
docker config create netfx-appsettings ./configs/appSettings.config

docker config create netfx-log4net ./configs/log4net.config

docker stack deploy -c docker-stack-v2.yml netfx
```

### v3 - add dependency checks

Uses utility app to check dependencies available for main app.

```
docker image build -t sixeyed/dcsf-netfx:v3 -f ./v3/Dockerfile .
```

Deploy with SQL container & secret:

```
docker secret create netfx-connectionstrings .\secrets\connectionStrings.config

docker stack deploy -c docker-stack-v3.yml netfx
```

### v4 - add healthcheck

Uses utility app to ping website in container.

```
docker image build -t sixeyed/dcsf-netfx:v4 -f ./v4/Dockerfile .
```

Deploy:

```
docker stack deploy -c docker-stack-v4.yml netfx
```


## Setup

- Windows VM
- Powershell
- Firefox
- VS Code for dwwx - Dockerfiles & compose

```
$env:workshop='C:\scm\github\sixeyed\docker-windows-workshop'
cd $env:workshop
```

## Demo 1 - Understand build images

Show images - `msbuild`, `nuget`, `dotnet`, `Get-WindowsFeature web*`

Windows Server Core:

```
docker container run -it --rm --entrypoint powershell `
 microsoft/windowsservercore:ltsc2016
```

.NET 4.7 build toolchain:

```
docker container run -it --rm --entrypoint powershell `
 microsoft/dotnet-framework:4.7.2-sdk
```

ASP.NET 4.7 runtime:

```
docker container run -it --rm --entrypoint powershell `
 microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
```

## Demo 2 - ASP.NET app monolith

Build app image:

```
docker image build -t dwwx/signup-web `
  -f .\docker\frontend-web\v1\Dockerfile .
```

Run app container:

```
docker container run `
  --detach --publish 8020:80 `
  dwwx/signup-web
```

> Browse to http://win2016-02:8020

Run stack, app & db container:

```
docker-compose -f .\app\v1.yml up -d
```

> Browse to http://win2016-02:8020

Check db.


## Demo 3 - Breaking out the front end

Build the new homepage:

```
docker image build `
  -t dwwx/homepage `
  -f .\docker\frontend-reverse-proxy\homepage\Dockerfile .
```

Run the homepage:

```
docker container run -d -p 8040:80 --name home dwwx/homepage
```

> Browse to http://win2016-02:8040

_Build the reverse proxy image:_

```
docker image build `
  -t dwwx/reverse-proxy `
  -f .\docker\frontend-reverse-proxy\reverse-proxy\Dockerfile .
```

Run the app with the new homepage & proxy:

```
docker-compose -f .\app\v2.yml up -d
```

> Browse to http://win2016-02:8020

Check db.


## Demo 4 - Breaking out the back end - APIs

Build the ASP.NET Core REST API:

```
docker image build `
  -t dwwx/reference-data-api `
  -f .\docker\backend-rest-api\reference-data-api\Dockerfile .
```

Run the API:

```
docker container run `
  --detach --publish 8060:80 `
  -e ConnectionStrings:SignUpDb="Server=signup-db;Database=SignUp;User Id=sa;Password=DockerCon!!!" `
  dwwx/reference-data-api
```

> Browse to http://win2016-02:8060/api/countries

Check logs.

Run the app with the API:

```
docker-compose -f .\app\v3.yml up -d
```

> Browse to http://win2016-02:8020

Check db & API container logs.


## Demo 5 - Breaking out the back end - messaging

Build the message handler image:

```
docker image build `
  -t dwwx/save-handler `
  -f .\docker\backend-async-messaging\save-handler\Dockerfile .
```

Run with message queue & handler:

```
docker-compose -f .\app\v4.yml up -d
```

Check handler container logs.

> Browse to http://win2016-02:8020

Check db & handler container logs.
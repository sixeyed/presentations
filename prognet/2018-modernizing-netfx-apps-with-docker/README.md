# Modernizing .NET Apps with Docker

Session from ProgNET London, 2018. The demos all use the sampel project from my Docker Windows Workshop, which you can follow through yourself with Windows 10 or Windows Server 2016. You'll find the workshop at https://dwwx.space

## Setup

- Docker
- Powershell
- Firefox
- Sqlectron
- VS Code for dwwx - Dockerfiles
- VS Code here - compose files

```
$env:workshop='C:\scm\github\sixeyed\docker-windows-workshop'
$env:demos='C:\scm\github\sixeyed\presentations\prognet\2018-modernizing-netfx-apps-with-docker'
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
> Browse to http://localhost:8020

Run stack, app & db container:

```
docker-compose -f $env:demos\app\v1.yml up -d
```

> Browse to http://localhost:8020

Check db.


## Demo 3 - Breaking out the back end

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

> Browse to http://localhost:8060/api/countries

Check logs.

Run the app with the API:

```
docker-compose -f $env:demos\app\v2.yml up -d
```

> Browse to http://localhost:8020

Check db.


## Demo 4 - Breaking out the front end

Run the app with the new homepage:

```
docker-compose -f $env:demos\app\v3.yml up -d
```

> Browse to http://localhost:8020

Check db.

## Pre-reqs

Either:

- Windows 10 with [Docker Desktop](https://www.docker.com/products/docker-desktop) *or*
- Windows Server 2016 with [Docker Enterprise](https://store.docker.com/editions/enterprise/docker-ee-server-windows)

## Setup

Clone the source code repo & switch to the `nsb` branch:

```
git clone https://github.com/sixeyed/docker-windows-workshop.git
cd docker-windows-workshop
git checkout nsb
```

Pull base & app images:

```
$images = 
'microsoft/dotnet-framework:4.7.2-sdk',
'microsoft/aspnet:4.7.2-windowsservercore-ltsc2016',
'microsoft/mssql-server-windows-express:2016-sp1',
'sixeyed/elasticsearch:5.6.11-nanoserver-sac2016',
'sixeyed/kibana:5.6.11-windowsservercore-ltsc2016',
'dwwx/save-handler:nsb',
'dwwx/index-handler:nsb',
'dwwx/reference-data-handler:nsb'

$images | foreach { docker image pull $_ }
```

## Demo 1 - build & run monolith

Build from source using Docker:

```
docker image build -t dwwx/signup-web:nsb `
  -f .\docker\frontend-web\v2\Dockerfile .
```

Run the web app & SQL Server containers:

```
mkdir C:\nsb-data

docker-compose -f .\app\v1.yml up -d
```

Browse to the app container:

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_signup-web_1

firefox "http://$ip/app"
```

Enter details and check in SQL Server:

```
docker container exec app_signup-db_1 `
  powershell `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

> If time, run the end-to-end tests

```
docker container run dwwx/e2e-tests
```

## Demo 2 - use command message handler for save

```
docker-compose -f .\app\v2.yml up -d
```

Browse to the app container:

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_signup-web_1

firefox "http://$ip/app"
```

Enter details and check handler logs:

```
docker container logs app_signup-save-handler_1
```

Check in SQL Server:

```
docker container exec app_signup-db_1 `
  powershell `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

> If time, run the end-to-end tests

```
docker container run dwwx/e2e-tests
```

## Demo 3 - use pub-sub message handler for analytics

```
docker-compose -f .\app\v3.yml up -d
```

Refresh web app (same IP),  check handler logs:

```
docker container logs app_signup-save-handler_1

docker container logs app_signup-index-handler_1
```

Check in SQL Server:

```
docker container exec app_signup-db_1 `
  powershell `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

Open Kibana:

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_kibana_1

firefox "http://$($ip):5601"
```

Create index `prospects` and check data.


## Demo 4 - use request-response message handler for reference data

```
docker-compose -f .\app\v4.yml up -d
```

Browse to the app container:

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_signup-web_1

firefox "http://$ip/app"
```

Check handler logs:

```
docker container logs app_signup-reference-data-handler_1

```

Enter data, check saves:

```
docker container logs app_signup-save-handler_1

docker container logs app_signup-index-handler_1
```

Check in SQL Server:

```
docker container exec app_signup-db_1 `
  powershell `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

Refresh Kibana (same IP).

## Demo 5 - switch to RabbitMQ

Start Rabbit first:

```
docker-compose -f .\app\v4.yml -f .\app\v4-rabbitmq.yml up -d rabbitmq
```

Browse to Rabbit management UI (credentials `guest`/`guest`):

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_rabbitmq_1

firefox "http://$($ip):15672"
```

Upgrade rest of app:

```
docker-compose -f .\app\v4.yml -f .\app\v4-rabbitmq.yml up -d
```

Check handler logs - confirm Rabbit MQ transport:

```
docker container logs app_signup-reference-data-handler_1
```

Refresh Rabbit MQ UI - show exchanges & queues.

Browse to the app container:

```
$ip = docker container inspect `
  --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' app_signup-web_1

firefox "http://$ip/app"
```

Enter data, check saves:

```
docker container logs app_signup-save-handler_1

docker container logs app_signup-index-handler_1
```

Check in SQL Server:

```
docker container exec app_signup-db_1 `
  powershell `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

Refresh Kibana.

## Demo 6 - CI

CI process:

```
.\ci\01-build.ps1
.\ci\02-run.
.\ci\03-test.ps1
```
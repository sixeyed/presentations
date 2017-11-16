
## Setup

- Switch to Linux containers

- Add IP address to SQL Azure firewall

- Run

\\\
cd C:\scm\github\sixeyed\presentations\future-decoded\201711-open-cloud\bulletin-board; \
Set-MpPreference -DisableRealTimeMonitoring $true; \
docker network create bb-net; \
drmf; \
rm -force -r C:\fd17
\\\

## Demo 1

docker container run \
  --detach \
  --env 'ACCEPT_EULA=Y' \
  --env 'MSSQL_SA_PASSWORD=DockerCon!!!' \
  --publish 1433:1433 \
  --network bb-net \
  --name sql-db \
  microsoft/mssql-server-linux:2017-CU1

Connect and run SQL script

## Demo 2

docker image build --tag sixeyed/bulletin-board .

docker container run \
  --detach \
  --publish 8080:8080 \
  --network bb-net \
  sixeyed/bulletin-board

Browse to http://localhost:8080

> Deploy compose file to UCP

https://fd17.westeurope.cloudapp.azure.com

## Demo 3

> Switch to Windows containers

ConvertTo-Dockerfile \
  -ImagePath C:\VMs\win2003-iis.vhd \
  -OutputPath C:\fd17 \
  -Artifact IIS -ArtifactParam BulletinBoard \
  -Verbose

cd C:\fd17

docker image build --tag sixeyed/bb-mta .

docker container run \
 --detach --publish-all \
 --name bb-mta \
 sixeyed/bb-mta

docker container inspect bb-mta

## Bonus 

docker image tag sixeyed/bb-mta dtr.sixeyed.com/fd17/bb-mta

docker image push dtr.sixeyed.com/fd17/bb-mta

> Deploy stack file to UCP

https://ucp.sixeyed.com
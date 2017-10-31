
## Setup

> Switch to Linux containers

docker network create bb-net

drmf

## Demo 1

docker container run `
  --detach `
  --env "ACCEPT_EULA=Y" `
  --env "MSSQL_SA_PASSWORD=DockerCon!!!" `
  --publish 1433:1433 `
  --network bb-net `
  microsoft/mssql-server-linux:2017-CU1

Connect and run SQL script

## Demo 2

docker image build sixeyed/bulletin-board

docker container run `
  --detach `
  --publish 8080:8080 `
  --network bb-net `
  sixeyed/bulletin-board

> Deploy compose file to UCP

https://fd17.westeurope.cloudapp.azure.com

## Demo 3

> Switch to Windows containers

ConvertTo-Dockerfile `
  -ImagePath C:\VMs\win2003-iis.vhd `
  -OutputPath C:\fd17-2 `
  -Artifact IIS -ArtifactParam BulletinBoard `
  -Verbose

docker image build -t sixeyed/bb-mta .

docker container run -d -P sixeyed/bb-mta

## Bonus 

docker image tag sixeyed/bb-mta dtr.sixeyed.com/fd17/bb-mta

docker image push dtr.sixeyed.com/fd17/bb-mta

> Deploy stack file to UCP

https://ucp.sixeyed.com
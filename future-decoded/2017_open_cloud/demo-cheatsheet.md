

## Demo 1

docker network create bb-net

docker container run `
  --detach `
  --env "ACCEPT_EULA=Y" `
  --env "MSSQL_SA_PASSWORD=DockerCon!!!" `
  --publish 1433:1433 `
  --network bb-net `
  microsoft/mssql-server-linux:2017-CU1

## Demo 2

docker container run `
  --detach `
  --publish 8080:8080 `
  --network bb-net `
  sixeyed/bulletin-board
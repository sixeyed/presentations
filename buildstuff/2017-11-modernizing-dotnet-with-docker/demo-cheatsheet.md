

# Demo 1 - run some sample containers

IIS:

```
docker container run --detach --publish 8081:80 microsoft/iis
```

SQL Server:

```
docker container run --detach --publish 1433:1433 \
 --env-file db-credentials.env \
 --name signup-db \
 microsoft/mssql-server-windows-express
```

## Demo 2 - app v1

Build with MSI:

```
docker image build --tag signup-web:v1 --file docker/web/Dockerfile.v1 .
```

Run:

```
docker container run --detach --publish 80:80 --env-file db-credentials.env --name signup-web signup-web:v1
```

## Demo 3 - app v2

- Update SignUp.aspx.cs to publish event. 

- Walk through message handler code.

Build message handler:

```
docker image build --tag save-handler --file docker/save-handler/Dockerfile .
```

Build web app v2:

```
docker image build --tag signup-web:v2 --file docker/web/Dockerfile.v2 .
```

Run message queue:

```
docker container run --detach --name message-queue nats
```

Replace web app with v2:

```
docker container rm -f signup-web

docker container run --detach --publish 80:80 --env-file db-credentials.env --name signup-web signup-web:v2
```

Run message handler:

```
docker container run --detach --env-file db-credentials.env save-handler
```

## Demo 4 - app v3

Run CMS:

```
docker container run --detach --publish 8088:80 --name homepage umbraco:v1
```

Run proxy:

```
docker container run --detach --publish 8090:80 --name proxy nginx
```

# Demo 1

Basic SQL Server instance:

```
docker container run -d -P `
 -e ACCEPT_EULA=Y `
 -e SA_PASSWORD=DockerCon!!! `
 microsoft/mssql-server-windows-express
```


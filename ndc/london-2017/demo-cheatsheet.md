
## Run the SQL Server container

```
docker run -d -p 1433:1433 -e sa_password=NDC_l0nd0n -e ACCEPT_EULA=Y --name productlaunchdb --ip 172.20.244.163 microsoft/mssql-server-windows-express
```
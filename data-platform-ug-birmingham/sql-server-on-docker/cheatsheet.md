
# Demo 1

Basic SQL Server instance:

```
docker container run -d -P `
 -e ACCEPT_EULA=Y `
 -e SA_PASSWORD=DockerCon!!! `
 microsoft/mssql-server-windows-express
```

* Connect with VS Code
* Run basic queries

# Demo 2

SQL with schema in scripts - no data volume:

```
cd db2

docker image build -t db2 .

docker container run -d -P db2
```

* Connect with VS Code
* Insert data
* `container exec` and view files
* Kill container
* Repeat - no data stored

# Demo 3 

SQL with schema in scripts - with mapped volume:

```
docker container run -d -P -v C:\db\db2:C:\mssql db2
```

* As demo 2; on repeat - data is retained

# Demo 4

SQL with Dacpac:

```
cd db3

docker image build -t db3 .

docker container run -d -P db3
```

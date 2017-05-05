
# Demo 1 - Windows Docker Containers

Task container:

```
docker run microsoft/nanoserver powershell Write-Output Hello Docker London
```

Interactive container:

```
docker run -it microsoft/windowsservercore powershell
```

Server container:

```
docker run -d -p 80:80 microsoft/iis
```

Custom image:

```
docker build -t static .
docker run -d -p 8081:80 static
```

# Demo 2 - Docker Compose with Windows Apps

Clean up:

```
docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

Run:

```
docker-compose up -d
```

Check Dockerfiles, then test web app. Show data:

```
docker exec [containter] `
 powershell -Command `
  "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database ProductLaunch"
```

Show Kibana.

# Demo 3 - Hybrid Swarm in Azure

Switch to swarm

```
```

URLs:

- [UCP](https://ddc-ucp606684.northeurope.cloudapp.azure.com/#/dashboard)
- [DTR](https://ddc-dtr975144.northeurope.cloudapp.azure.com/repositories)

- [Voting app](http://ddc-linux-1.northeurope.cloudapp.azure.com:5000/)
- [Voting results](http://ddc-linux-1.northeurope.cloudapp.azure.com:5001/)

- [Pi app](http://ddc-win-1.northeurope.cloudapp.azure.com/)
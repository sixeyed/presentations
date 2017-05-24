
# Docker on Windows 101

## Basic container usage

Task container:

```
docker run microsoft/nanoserver powershell Write-Output Hello Red Shirt Dev Tour!
```

Interactive container:

```
docker run -it microsoft/windowsservercore powershell
```

Background container:

```
docker run -d -P --name iis microsoft/iis:nanoserver
```

## Build, ship and run

Build tweet app:

```
docker build -t sixeyed/tweet-app .
```

Push to [sixeyed/tweet-app](https://cloud.docker.com/swarm/sixeyed/repository/registry-1.docker.io/sixeyed/tweet-app/general) on Docker Cloud:

```
docker push sixeyed/tweet-app
```

RDP to `win-node00.westeurope.cloudapp.azure.com` and:

```
docker run -d -P sixeyed/tweet-app
```

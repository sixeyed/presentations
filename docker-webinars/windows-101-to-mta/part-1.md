
# Docker on Windows 101

## Basic container usage

Task container:

```
docker container run microsoft/nanoserver powershell Write-Output Hello.
```

Interactive container - list filesystem, Windows features, processes:

```
docker container run --interactive --tty microsoft/windowsservercore powershell
```

Background container - run and browse:

```
docker container run --detach --publish-all --name iis microsoft/iis:nanoserver

docker container inspect iis
```

## Build, ship and run

Build sample app:

```
cd .\part-1\hostname-app

docker image build --tag sixeyed/hostname-app .
```

Push to [sixeyed/hostname-app](https://cloud.docker.com/swarm/sixeyed/repository/registry-1.docker.io/sixeyed/tweet-app/general) on Docker Cloud:

```
docker image push sixeyed/hostname-app
```

Run one copy:

```
docker container run --detach --publish-all --name app sixeyed/hostname-app

docker container inspect app
```

Run multiple:

```
for ($i=0; $i -lt 5; $i++) {
    & docker run --detach --publish-all --name "app-$i" sixeyed/hostname-app
}
```

Browse all:

```
for ($i=0; $i -lt 10; $i++) {
    $ip = & docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' "app-$i"
    start "http://$ip"
}
```
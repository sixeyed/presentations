# 5 Patterns for Success for Application Transformation

Demo cheatsheet.

## Pre-reqs

A hybrid Docker swarm cluster, with Linux and Windows nodes (I use [Docker Enterprise on Azure](https://dockr.ly/azure)).

Demo with:

- 1x Firefox opened to [UCP](https://ucp.sixeyed.com)
- 1x VS Code opened to this folder
- 1x terminal connected to UCP

Setup environment & deploy baseline apps:

```
./demo-setup.ps1
```

## Demo 1 - Logging (.NET)

- browse to [Windows LB](http://wlb.sixeyed.com:8090)
- click _Write Logs_
- check service/container logs
- nothing

Relays app log file to Docker:

```
docker stack deploy `
 -c ./netfx/swarm/docker-stack-v1.yml netfx
```

- repeat - logs written

## Demo 2 - Config

- show config values on app
- check default `appSettings.config` and `log4net.config`

```
docker stack deploy `
 -c ./netfx/swarm/docker-stack-v2.yml netfx
```

- check swarm configs

```
docker config inspect netfx-appsettings --pretty
docker config inspect netfx-log4net --pretty
```

- repeat

## Demo 3 - Dependencies

- click _Execute SQL_ - fails

```
docker stack deploy `
 -c ./netfx/swarm/docker-stack-v3.yml netfx
```

- show logs - dependency check
- show database server namwe
- click _Execute SQL_ - works

```
docker secret inspect netfx-connectionstrings --pretty
```

## Demo 4 - Health

- slow mode indicates issue, should restart

```
docker stack deploy `
 -c ./netfx/swarm/docker-stack-v4.yml netfx
```

- refresh & check container ID

## Demo 5 - Monitoring

```
docker stack deploy `
 -c ./netfx/swarm/docker-stack-v5.yml netfx
```

- browse to [Prometheus website](http://llb.sixeyed.com:9080)
- query `w3svc_w3wp_requests_per_sec`

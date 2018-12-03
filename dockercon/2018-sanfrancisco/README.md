# 5 Patterns for Success for Application Transformation

Demo cheatsheet.

## Pre-reqs

A hybrid Docker swarm cluster, with Linux and Windows nodes (I use Docker Enterprise Edition in the DockerCon session).

Demo with:

- 1x Firefox opened to [UCP](https://ub1604-01)
- 1x VS Code opened to this folder
- 1x terminal connected to UCP

Setup environment:

```
cd ~/ucp/ub1604-01/bundle/

eval "$(<env.sh)"

cd ~/scm/github/sixeyed/presentations/dockercon/2018-sanfrancisco
```

Create configs & secrets for Java:

```
docker config create java-logging ./java/swarm/configs/logging.properties
docker config create java-web ./java/swarm/configs/web.xml
docker secret create java-context ./java/swarm/secrets/context.xml
```

Create configs & secrets for Java:

```
docker config create netfx-appsettings ./netfx/swarm/configs/appSettings.config
docker config create netfx-log4net ./netfx/swarm/configs/og4net.config
docker secret create netfx-connectionstrings ./netfx/swarm/secrets/connectionStrings.config
```

Deploy baseline apps:

```
docker stack deploy -c ./netfx/swarm/docker-stack-v0.yml netfx

docker stack deploy -c ./java/swarm/docker-stack-v1.yml java
```

## Demo 1 - Logging (.NET)

- browse to [Windows node](http://wlb.sixeyed.com:8080)
- click _Write Logs_
- check service/container logs
- nothing

Relays app log file to Docker:

```
docker stack deploy \
 -c ./netfx/swarm/docker-stack-v1.yml \
 netfx  #1
```

- repeat - logs written

## Demo 2 - Config (Java)

- browse to [Linux node](http://llb.sixeyed.com:8070)
- check service/container logs
- click _Write Logs_
- nothing

```
docker stack deploy \
 -c ./java/swarm/docker-stack-v2.yml \
 java  #2
```

- check default `Web.xml` and `logging.properties`
- check swarm `Web.xml` and `logging.properties`

```
docker config inspect java-logging --pretty
```

- repeat
  -logs

## Demo 3 - Dependencies (.NET)

- click _Execute SQL_ - fails

```
docker stack deploy \
 -c ./netfx/swarm/docker-stack-v3.yml \
 netfx  #3
```

- show logs - dependency check
- show database server namwe
- click _Execute SQL_ - works

```
docker config inspect netfx-log4net --pretty
```

## Demo 4 - Health (Java)

- slow mode indicates issue, should restart

```
docker stack deploy \
 -c ./java/swarm/docker-stack-v4.yml \
 java  #4
```

- refresh & check container ID

## Demo 5 - Monitoring (.NET)

```
docker stack deploy \
 -c ./netfx/swarm/docker-stack-v5.yml \
 netfx  #5
```

- browse to [Prometheus website](http://llb.sixeyed.com:9080)
- query `w3svc_w3wp_requests_per_sec`

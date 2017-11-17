
## Prep

Switch to swarm:

```
cd ~/ucp/ddc086-bundle-elton

. ./env.sh

cd ~/scm/github/sixeyed/presentations/buildstuff/2017-11-hybrid-docker-swarm
```

## Demo 1

Explore swarm:

```
docker node ls

docker node inspect

docker secret ls

docker secret inspect
```

Run IIS service on swarm:

```
docker service create \
 --detach \
 --endpoint-mode dnsrr \
 --publish mode=host,target=80,published=80 \
 --constraint 'node.platform.os == windows' \
 --name iis \
 microsoft/iis:nanoserver
```

## Demo 2

V1 - running in Windows containers & SQL Azure:

```
docker service rm iis

docker stack deploy -c docker-stack.v1.yml buildstuff
```

V2 - move NATS to Linux

```
docker stack deploy -c docker-stack.v2.yml buildstuff
```

Try... Then restart web, msg handler and proxy

V3 - add Elasticsearch & kibana

```
docker stack deploy -c docker-stack.v3.yml buildstuff
```

V4 - move Nginx to Linux

```
docker stack deploy -c docker-stack.v4.yml buildstuff
```


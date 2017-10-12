
## Part 1

```
docker version
```

Switch to remote Docker swarm:

```
cd "$env:sessions\techdays-nl\ucp-bundle-elton\"

. .\env.ps1

docker node ls
```

Deploy stack:

```
docker stack deploy -c .\docker-stack.v1.yml newsletter

docker service ls
```

> Walk through stack file: service defintions & node constraints.

[Browse to site](http://sixeyed.westeurope.cloudapp.azure.com).

- fill in form
- check data in [Kibana](http://sixeyed.westeurope.cloudapp.azure.com:5601)

## Part 2

Deploy v2:

```
docker stack deploy -c .\docker-stack.v2.yml newsletter

docker service ls
```

> Walk through stack file: updating NATS service.

Browse to site. Submit form - breaks.

Restart dependent services:

```
docker service update --force newsletter_web

docker service update --force newsletter_save-handler

docker service update --force newsletter_index-handler
```

Submit & check in Kibana.

## Part 3

Deploy v3:

```
docker stack deploy -c .\docker-stack.v3.yml newsletter

docker service update --force newsletter_index-handler

docker service ls
```

> Walk through stack file: updating Elastic services.

Submit & check in [Kibana on Linux node](http://ddc-linux.westeurope.cloudapp.azure.com:5601).


## Part 4

Deploy v4:

```
docker stack deploy -c .\docker-stack.v4.yml newsletter

docker service ls
```

> Walk through stack file: updating secrets.

Submit & check in Kibana on Linux node, and SQL Azure.

## Part 5

Walkthrough [UCP](https://ucp.sixeyed.com):

- nodes
- services
- container logs & command - Linux
- container logs & command - Windows

# Hybrid Docker Swarm

My session from NDC Oslo, 2017. You can run this yourself, but you will need a hybrid Docker swarm. 

## Setup

My swarm was:

- 1x Ubuntu VM with 2GB RAM, as swarm manager
- 1x Ubuntu VM with 3GB RAM, as worker
- 1x Windows Server 2016 Core VM with 2.5GB RAM as worker.

Run `docker swarm init` on the manager, and `docker swarm join` on the others (with the token from the manager). You also need a label on the 3.5GB node:

```
docker node update --label-add ram=l <nodeId>
```

> The Linux SQL Server container won't start unless it has 3GB RAM, and the label is used in a constraint.

I also ran the Vizualizer container (see [start-viz.sh](start-viz.sh)).

## v1 - all Windows

Deploy stack - all Windows containers - check in viz and test app:

```
docker stack deploy -c docker-stack.v1.yml signup
```

## v2 - NATS on Linux

Replace NATS message queue with Linux container:

```
docker stack deploy -c docker-stack.v2.yml signup
```

## v3 - Elastic on Linux

Replace Elasticsearch and Kibana with Linux containers:

```
docker stack deploy -c docker-stack.v3.yml signup
```

## v4 - SQL Server on Linux

Replace SQL Server with Linux container:

```
docker stack deploy -c docker-stack.v4.yml signup
```
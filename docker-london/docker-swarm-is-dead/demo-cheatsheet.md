
##Run the demos


#### Demo 1 - set up Swarm

Create the swarm using node '00 as the manager:

```
ssh badapi-swarm-00.northeurope.cloudapp.azure.com
docker swarm init --listen-addr 10.0.0.4:2377
```

Now join the workers to the swarm:

```
ssh badapi-swarm-01.northeurope.cloudapp.azure.com 'docker swarm join --listen-addr 10.0.0.5:2377 10.0.0.4:2377'
ssh badapi-swarm-02.northeurope.cloudapp.azure.com 'docker swarm join --listen-addr 10.0.0.6:2377 10.0.0.4:2377'
ssh badapi-swarm-03.northeurope.cloudapp.azure.com 'docker swarm join --listen-addr 10.0.0.7:2377 10.0.0.4:2377'
```

##Demo 2 - create the app infrastructure:

Create the network:

```
docker network create -d overlay badapi
```

Create the infrastructure services - Redis and Elasticsearch:

```
docker service create --name redis --network badapi redis
docker service create --name elasticsearch --network badapi elasticsearch
```

Verify the discovery part by creating a utility service in the same network:

```
docker service create --name util --network badapi sixeyed/ubuntu-with-utils ping google.com
```

Now you can SSH into the node running the utility task, connect to the container and explore the swarm with:

```
curl http://elasticsearch:9200
dig elasticsearch
telnet redis 6379
```


### Demo 3 - end to end

Run the application services - REST API, message handler and Kibana front end:

```
docker service create --name badapi-indexer --network badapi sixeyed/badapi-indexer
docker service create --name kibana --network badapi --publish 5601:5601 kibana
docker service create --name badapi-api --network badapi --publish 80:5000 sixeyed/badapi-api
```

Find out where the API task is running and then curl the API (assumes '00 here):

```
docker service tasks badapi-api
curl -v http://badapi-swarm-00.northeurope.cloudapp.azure.com/
```


Now curl to all other workers - lo and behold! The API responds from any node, even though the container is only running on one:

```
curl -v http://badapi-swarm-01.northeurope.cloudapp.azure.com/
curl -v http://badapi-swarm-02.northeurope.cloudapp.azure.com/
curl -v http://badapi-swarm-03.northeurope.cloudapp.azure.com/
```


And also from the load balancer:

```
curl -v http://badapi-swarm-public.northeurope.cloudapp.azure.com/
```

Now you can browse to Kibana on http://badapi-swarm-public.northeurope.cloudapp.azure.com:5601 and play around with the data, in the index `api-responses`.

# Kubernetes 101 

These demo docs at https://is.gd/apagut.

Session slides at https://is.gd/veciti.

Source code for the bulletin board app at [dockersamples/node-bulletin-board](https://github.com/dockersamples/node-bulletin-board).

## Setup

Run Kubernetes locally with [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [kind](https://kind.sigs.k8s.io/docs/user/quick-start/), or use a playground like [Play with Kubernetes](https://labs.play-with-k8s.com) or [Katacoda](https://www.katacoda.com/courses/kubernetes/playground).

Clone this repo & switch to the resources:

```
git clone --depth 1 https://github.com/sixeyed/presentations.git

cd presentations/tech-ug/202005-kubernetes-101/
```

## Demo 1 - Events App in Docker

Create a network for containers to connect on:

```
docker network create bb-net
```

Run the database container:

```
docker container run --detach --network bb-net --name bb-db sixeyed/bulletin-board-db:v2

docker container ls

docker container logs bb-db
```

And the web app container:

```
docker container run --detach --network bb-net --name bb-web --publish 8080:8080 sixeyed/bulletin-board-app:v2

docker container ls

docker container logs bb-web
```

> Browse to http://localhost:8080

No resilience - kill the app container process:

```
docker exec bb-web killall5

docker container ls
```

And remove the database container:

```
docker container rm -f bb-db

docker container ls
```

## Demo 2 - Sleep in Kubernetes

> Walk through [sleep.yaml](sleep.yaml).

Simple Deployment:

```
kubectl apply -f sleep.yaml

kubectl get pods --show-labels

kubectl describe pod -l app=sleep

docker container ls

kubectl exec deploy/sleep -- hostname
```

Pod restart:

```
kubectl exec deploy/sleep -- killall5

kubectl get pods
```

Pod replacement:

```
kubectl delete pods -l app=sleep

kubectl get pods
```

## Demo 3 - Web

> Walk through [bb-web-service.yaml](web/bb-web-service.yaml) and [bb-web.yaml](web/bb-web.yaml).

Deploy all:

```
kubectl apply -f web/

kubectl get svc
```

Check status:

```
kubectl get pods -l app=bb-web

kubectl logs -l app=bb-web
```

Check network:

```
kubectl get svc bb-web

kubectl exec deploy/sleep -- nslookup bb-web

kubectl exec deploy/sleep -- curl -s http://bb-web:8080
```

## Demo 4 - Database

> Walk through [bb-db-service.yaml](db/bb-db-service.yaml), [bb-db.yaml](db/bb-db.yaml) and [bb-db-secret.yaml](db/bb-db-secret.yaml).

Deploy all:

```
kubectl apply -f db/

kubectl get svc

kubectl get pods -l app=bb-db

kubectl logs -l app=bb-db
```

Check app status:

```
kubectl get pods -l app=bb-web

kubectl delete pods -l app=bb-web
```

Get URL & browse:

```
kubectl get svc bb-web -o jsonpath='http://{.status.loadBalancer.ingress[0].*}:8080'
```

Scale up:

```
kubectl scale deploy/bb-web --replicas=3

kubectl get pods -l app=bb-web

kubectl get endpoints bb-web
```

> Browse and refresh 

```
for($i = 0; $i -lt 10; $i++) { curl http://localhost:8080 | Out-Null }
```

Check load balancing:

```
kubectl logs -l app=bb-web --tail 1
```

## Teardown

All the objects are labelled with `demo=kube101`, so we can delete them all using a label selector.

```
kubectl get all -l demo=kube101

kubectl delete all -l demo=kube101
```
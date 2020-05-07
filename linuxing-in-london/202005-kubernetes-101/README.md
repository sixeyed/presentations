# Kubernetes 101 & Workshop

These demo docs at https://is.gd/sinivi.

Session slides at https://is.gd/uquzut.

Video at https://youtu.be/dDLrvc9IVq4.

## Setup

Run Kubernetes locally with [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [kind](https://kind.sigs.k8s.io/docs/user/quick-start/), or use a playground like [Play with Kubernetes](https://labs.play-with-k8s.com) or [Katacoda](https://www.katacoda.com/courses/kubernetes/playground).

Clone this repo & switch to the resources:

```
git clone --depth 1 https://github.com/sixeyed/presentations.git

cd presentations/linuxing-in-london/202005-kubernetes-101/
```

## Demo 1 - Sleep

> Walk through [sleep.yaml](sleep.yaml).

Simple Pod:

```
kubectl apply -f sleep.yaml

kubectl get pods --show-labels

kubectl describe pod -l app=sleep

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

## Demo 2 - Web

> Walk through [bb-web-service.yaml](web/bb-web-service.yaml) and [bb-web.yaml](web/bb-web.yaml).

Deploy all:

```
kubectl apply -f web/

kubectl get svc

kubectl get all -l app=bb-web
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

kubectl exec deploy/sleep -- curl http://bb-web:8080
```

## Demo 3 - Database

> Walk through [bb-db-service.yaml](db/bb-db-service.yaml), [bb-db.yaml](db/bb-db.yaml) and [bb-db-secret.yaml](db/bb-db-secret.yaml).

Deploy all:

```
kubectl apply -f db/

kubectl get svc

kubectl get all -l app=bb-db
```

Check app status:

```
kubectl get pods -l app=bb-web
```

Get URL & browse:

```
kubectl get svc bb-web -o jsonpath='http://{.status.loadBalancer.ingress[0].*}:8080'
```

Scale up:

```
kubectl scale deploy/bb-web --replicas=3
```
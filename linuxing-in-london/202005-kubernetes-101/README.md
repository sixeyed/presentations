# Docker 101 & Workshop

These demo docs at https://is.gd/.

Session slides at https://is.gd/.

Video at https://youtu.be/dDLrvc9IVq4.

## Demo 1 - Sleep

Walk through [sleep.yaml](sleep.yaml).

Simple Pod:

```
kubectl apply -f sleep.yaml

kubectl get pods --show-labels

kubectl get all -l app=sleep

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

Walk through [bb-web-service.yaml](web/bb-web-service.yaml) and [bb-web.yaml](web/bb-web.yaml).

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

Walk through [bb-db-service.yaml](db/bb-db-service.yaml), [bb-db.yaml](db/bb-db.yaml) and [bb-db-secret.yaml](db/bb-db-secret.yaml).

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
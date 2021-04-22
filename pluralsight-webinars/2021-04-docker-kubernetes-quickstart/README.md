# Docker and Kubernetes Quickstart

You can follow along with the demos - you need:

- [Docker Desktop]() to run the Docker demos
- [Windows 10]() to run the Windows container demos
- an Azure account and the [az command]() for the Azure Kubernetes demos

## Demo 1 - Docker

> Windows container mode

* [Petshop web Dockerfile](petshop/web/Dockerfile)

```
docker run -p 8080:80 sixeyed/petshop-web:1809
```

Browse to http://localhost:8080 (fails)

> Linux container mode

* [Access Log API Dockerfile](apod/access-log/Dockerfile)

```
docker run -d -p 8030:80 psdockerprod/access-log:m2
```

Browse to http://localhost:8030/stats


* [Image API Dockerfile](apod/image-of-the-day/Dockerfile)

```
docker run -d --name api -p 8010:80 psdockerprod/image-of-the-day:m2

docker logs api
```

Browse to http://localhost:8010/image

```
docker logs api
```


## Demo 2 - Docker Compose

> Windows container mode

* [Petshop Docker Compose file](petshop/docker-compose.yml)

```
docker rm -f $(docker ps -aq)

docker-compose -f ./petshop/docker-compose.yml up -d

docker ps
```

Browse to http://localhost:8080 and http://localhost:8085/ProductService.svc?wsdl

> Linux container mode

* [APOD Docker Compose file](apod/docker-compose.yml)

```
docker rm -f $(docker ps -aq)

docker-compose -f ./apod/docker-compose.yml up -d

docker ps
```

Browse to http://localhost:8020/image and http://localhost:8010

## Demo 3 - Kubernetes

Deploying new and old apps in the cloud - using the setup instructions in [AKS](aks.md).

_Check the current status:_

```
kubectl get nodes

kubectl get pods
```

_Deploy the ingress controller:_

```
kubectl apply -f ./kubernetes/ingress-controller

kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx
```

This is a routing component for making multiple apps available on the cluster. We'll run the APOD app - here's how the image API looks in Kubernetes: [apod-api.yaml](kubernetes/apod/apod-api.yaml).

_Deploy the new Linux app:_

```
kubectl apply -f ./kubernetes/apod

kubectl get pods -n apod

dig apod.sixeyed.com
```

Browse to:

* http://apod.sixeyed.com - web
* http://api.apod.sixeyed.com/image - API

_And the old Windows app:_

```
kubectl apply -f ./kubernetes/petshop

kubectl get pods -n petshop

dig petshop.sixeyed.com
```

Browse to:

* http://petshop.sixeyed.com - app
* http://ws.petshop.sixeyed.com/ProductService.svc?wsdl - SOAP service

## Teardown

Remove all the custom Kubernetes namespaces:

```
kubectl delete ns -l pswebinar=21.04
```

Or just delete the whole RG:

```
az group delete -n ps2104
```

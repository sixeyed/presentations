# Migrating WCF apps to Azure Kubernetes Service

The demo app for the session is the .NET 3.5 PetShop from 2008.

> Source code for the app is in [sixeyed/petshopvnext](https://github.com/sixeyed/petshopvnext/tree/dotnetconf2020)

- Demo 1 runs the app as-is in Kubernetes
- Demo 2 adds a new REST API in .NET 5

## Setup

Clone this repo. Switch to the `kubernetes` directory:

```
cd kubernetes
```

Create an [AKS cluster with Windows nodes](azure.md).

Check cluster:

```
kubectl get nodes -o wide

kubectl get node aksakswin000000 --show-labels
```

## Demo 1 - PetShop 

Run locally:

```
cd docker

docker-compose up -d
```

Walkthrough: 

- Docker Compose model in [docker-compose.yml](docker/docker-compose.yml)
- WCF deployment in [Dockerfile](docker/webservice/Dockerfile)
- SQL Server deployment in [Dockerfile](docker/db/Dockerfile)

> Test locally at http://localhost:8080/ and http://localhost:8085/ProductService.svc?wsdl

Run in AKS - deploy the ingress controller:

```
kubectl apply -f ingress-controller/
```

Walk through: 

- Nginx cache configuration in [nginx-ingress-config.yaml](./ingress-controller/nginx-ingress-config.yaml)
- Service IP in [nginx-ingress-service.yaml](./ingress-controller/nginx-ingress-service.yaml)

Verify:

```
kubectl get pods -n ingress-nginx -o wide

kubectl get svc -n ingress-nginx
```

Deploy the 2008 Petshop app:

```
kubectl apply -f petshop/
```

Walk through: 

- Connection string Secret in [connection-string.yaml](./petshop/web-connection-string.yaml)
- Ingress with sticky sessions & cache in [ingress.yaml](./petshop/web-ingress.yaml)
- Deployment - with resources, secrets, nodeSelector - in [web.yaml](./petshop/web.yaml)

Verify:

```
kubectl get pods -n petshop

kubectl get ingress -n petshop

dig petshop.sixeyed.com
```

> Browse to the app at http://petshop.sixeyed.com

- App works :)
- Images are cached (X-Cache response header)
- Active pages not cached 

> And the SOAP Web Service at http://ws.petshop.sixeyed.com/ProductService.svc?wsdl

## Demo 2 - PetShop Products Service

Deploy the products service:

```
kubectl apply -f products-service/
```

Walk through: 

- Connection string Secret in [connection-string.yml](./products-service/connection-string.yaml)
- Ingress with cache for all (shorter) in [ingress.yaml](./products-service/ingress.yaml)
- Deployment - with nodeAffinity - in [web.yaml](./products-service/web.yaml)

Verify:

```
kubectl get pods -n petshop

kubectl get ingress -n petshop
```

> Browse to the API at http://api.petshop.sixeyed.com/products

- Clean API
- All new .NET 5 code
- Responses cached & compressed

> Check images for [product service](https://hub.docker.com/r/sixeyed/petshop-products-service/tags) and the [WCF app](https://hub.docker.com/r/sixeyed/petshop-webservice/tags)


## Demo 3 - Consistent management

ConfigMaps :

```
kubectl -n petshop get configmaps

kubectl -n petshop describe configmap petshop-app-settings
```

Secrets:

```
kubectl -n petshop get secrets

kubectl -n petshop describe secret petshop-connection-string

kubectl -n petshop describe secret petshop-services-connection-string
```

Logs:

```
kubectl logs -n petshop -l component=products-service

kubectl logs -n petshop -l component=web
```


## Teardown

Remove apps & ingress controller:

```
kubectl delete ns -l intmon=20.11
```
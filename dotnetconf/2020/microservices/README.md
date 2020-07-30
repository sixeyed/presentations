# Evolving .NET Framework Monoliths with .NET 5 and Kubernetes

The demo app for the session is the .NET 3.5 PetShop from 2008...

> Source code for the app is in [sixeyed/petshopvnext](https://github.com/sixeyed/petshopvnext)

- Demo 1 runs the app as-is in Kubernetes
- Demo 2 adds a new REST API in .NET 5
- Demo 3 encapsulates the database for the new service

## Setup

Create an [AKS cluster with Windows nodes](azure.md).

Check cluster:

```
kubectl get nodes

kubectl get node aksakswin000000 --show-labels
```

## Demo 1 - PetShop v4

Deploy the ingress controller:

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

Deploy the v1 Petshop app:

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


## Demo 3 - Encapsulate Product Data


Update web app to use Product Service:

```
kubectl apply -f petshop/update/
```

Walkthrough changes:

- AppSettings in [web-app-settings.yaml](./petshop/update/web-app-settings.yaml)
- Dockerfile for web app v4.1 from [sixeyed/petshopvnext]()

> Verify app still works

Check logs:

```
kubectl logs -n petshop -l component=products-service --tail 4
```

Update service to use CosmosDB:

```
kubectl apply -f products-service/update/
```

Walkthrough changes:

- Environment variables in [web.yaml](./products-service/update/web.yaml)
- Dockerfile for  product service from [sixeyed/petshopvnext]()

> Edit items in Cosmos & refresh API & web

## Teardown

Remove apps & ingress controller:

```
kubectl delete ns -l dotnetconf=2020
```
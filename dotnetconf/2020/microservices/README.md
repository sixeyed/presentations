
## Setup

Create an [AKS cluster with Windows nodes](aks.md).

Check cluster:

```
kubectl get nodes

kubectl get node aksakswin000000 --show-labels
```

## Demo 1 - PetShop v4

Deploy the [ingress controller](ingress-controller/nginx-ingress-controller.yaml):

```
kubectl apply -f ingress-controller/
```

Walk through: 

- Nginx cache configuration in [nginx-ingress-config.yaml(./ingress-controller/nginx-ingress-config.yaml)
- Service IP in [nginx-ingress-service.yaml(./ingress-controller/nginx-ingress-service.yaml)

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

- Connection string Secret in [connection-string.yaml](./petshop/connection-string.yaml)
- Ingress with sticky sessions & cache in [ingress.yaml](./petshop/ingress.yaml)
- Deployment - with resources, secrets, nodeSelector - in [web.yaml](./petshop/web.yaml)

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

> Browse to the API at http://api.petshop.sixeyed.com/products

- Clean API
- All new .NET 5 code
- Responses cached & compressed

> Check images for [product service](https://hub.docker.com/r/sixeyed/petshop-products-service/tags) and the [.NET 3.5 app](https://hub.docker.com/r/sixeyed/petshop-web/tags)

## Demo 3 - Encapsulate Product Data

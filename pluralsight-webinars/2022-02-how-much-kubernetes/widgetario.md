# Widgetario Sample App

A simple distributed system modelled in Kubernetes.

## Kubernetes manifests

_Products DB (Postgres):_

- [Service](widgetario/products-db/products-db-service.yaml)
- [Deployment](widgetario/products-db/deployment.yaml)
- [Secret](widgetario/products-db/secret-db-password.yaml)

_Products API (Java):_

- [Service](widgetario/products-api/products-api-service.yaml)
- [Deployment](widgetario/products-api/deployment.yaml)
- [Secret](widgetario/products-api/secret-db-properties.yaml)

_Stock API (Go):_

- [Service](widgetario/stock-api/stock-api-service.yaml)
- [Deployment](widgetario/stock-api/deployment.yaml)
- [Secret](widgetario/stock-api/secret-db-connection.yaml)

_Website (.NET Core):_

- [Service](widgetario/web/web-service.yaml)
- [Deployment](widgetario/web/deployments.yaml)
- [ConfigMap](widgetario/web/configmap-web-features.yaml)
- [Secret](widgetario/web/secret-web-api.yaml)

## Running the app

Deploy:

```
kubectl apply -f widgetario/products-db -f widgetario/products-api -f widgetario/stock-api -f widgetario/web
```

Print details:

```
kubectl get po -l app=widgetario

kubectl get svc
```

Test at http://localhost:8021
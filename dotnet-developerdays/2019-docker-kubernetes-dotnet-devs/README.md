# Docker and Kubernetes for .NET Developers

Session covering .NET apps in Kubernetes: .NET Core apps in Linux containers and .NET Framework apps in Windows containers, on the same AKS cluster.

## Pre-reqs

To build the apps and run containers locally:

- [Docker Desktop for Windows](https://hub.docker.com/?overlay=onboarding)

To run the apps in AKS:

- [AKS cluster with Windows nodes](https://docs.microsoft.com/en-us/azure/aks/windows-container-cli)

## Demo Setup

- VS Code here
- VS Code with PetShop source
- VS Code with To-Do List source [sixeyed/diamol](https://github.com/sixeyed/diamol)
- VS Code with dak4.net source
- Firefox

## Demo 1 - PetShop: Legacy .NET Fx 3.5 app

Walk through:

- db Dockerfile
- web Dockerfile
- webservice Dockerfile

Build locally:

```
docker image build -t petshopweb -f .\docker\web\Dockerfile .
```

Walk through docker-compose.yml

Deploy on server:

```
docker-compose -f ./01-petshop/docker-compose.yml up -d
```

Check:

```
docker container ls
```

> Browse to http://netdd19-lab2413101909000.westeurope.cloudapp.azure.com:8010/

## Demo 2 - PetShop in AKS

Walk through:

- [petshop-web.yml](./k8s/01-petshop/petshop-web.yml)
- [petshop-webservice.yml](./k8s/01-petshop/petshop-web.yml)

Connected to AKS:

```
kubectl get nodes
```

Secrets already there with Azure SQL connection string:

```
kubectl describe secret petshop-web-config
```

No apps running:

```
kubectl get deploy
```

Deploy on AKS:

```
kubectl apply -f ./k8s/01-petshop
```

Check:

```
kubectl get pods
```

Find IPs:

```
kubectl get svc petshop-web petshop-webservice
```

> Browse to http://40.74.8.211

> Browse to http://40.74.39.55

## Demo 3 - ToDoList: new .NET Core 3.0 app

Walk through:

- Dockerfile

```
docker image build -t todo .
```

Walk through:

- [docker-compose.yml](./compose/02-todo-list/docker-compose.yml)

Deploy on server

```
docker-compose -f ./02-todo-list/docker-compose.yml up -d
```

> Browse to http://netdd19-lab2413101909000.westeurope.cloudapp.azure.com:8030

Walk through:

- [todo-list.yml](./k8s/02-todo-list/todo-list.yml)

Secret already there with Azure Postgres connection string:

```
kubectl describe secret todo-list-config
```

Deploy on AKS:

```
kubectl apply -f ./k8s/02-todo-list/
```

Check:

```
kubectl get pods
```

Find IPs:

```
kubectl get svc todo-list-web
```

> Browse to http://40.74.17.200

## Demo 4 - SignUp: hybrid .NET Fx / .NET Core app

Walk through:

- web Dockerfile
- save-handler Dockerfile

Walk through:

- [docker-compose.yml](./compose/03-signup/docker-compose.yml)

Deploy on server

```
docker-compose -f ./03-signup/docker-compose.yml up -d
```

> Browse to http://netdd19-lab2413101909000.westeurope.cloudapp.azure.com:8040

Walk through:

- [signup-web.yml](./k8s/03-signup/signup-web.yml)
- [save-handler.yml](./k8s/03-signup/save-handler.yml)

Secret already there with Azure SQL connection strings:

```
kubectl get secrets
```

Deploy on AKS:

```
kubectl apply -f ./k8s/03-signup/
```

Check:

```
kubectl get pods
```

Find IPs:

```
kubectl get svc -n kube-system traefik-ingress-service
```

> Browse to http://40.74.34.151

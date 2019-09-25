# Putting the ".NET" into "Kubernetes" - [.NET Conf 2019](https://dotnetconf.net)

Session covering .NET apps in Kubernetes: .NET Core apps in Linux containers and .NET Framework apps in Windows containers, on the same AKS cluster.

## Pre-reqs

To build the apps and run containers locally:

- [Docker Desktop for Windows](https://hub.docker.com/?overlay=onboarding)

To run the apps in AKS:

- [AKS cluster with Windows nodes](https://docs.microsoft.com/en-us/azure/aks/windows-container-cli)

## Demo Setup

- Create To-Do List secrets
- Create Nerd Dinner secrets
- Azure Cloud Shell  `cd ./dotnetconf/apps`
- VS Code here
- VS Code with To-Do List source [sixeyed/diamol](https://github.com/sixeyed/diamol)
- VS Code with Nerd Dinner source [sixeyed/docker-on-windows](https://github.com/sixeyed/docker-on-windows)
- Firefox

## Demo 1 - .NET Core 3.0 running locally

> Walkthrough [Dockerfile](https://github.com/sixeyed/todo-list-dotnet/blob/master/Dockerfile)

```
docker image build -t dotnetconf/todo-list .
```

```
docker image ls dotnetconf/*
```

> Walkthrough [TodoList.proj]()

Run locally with Sqlite:

```
docker container run -d -p 8098:80 dotnetconf/todo-list
```

> Browse to http://localhost:8098

## Demo 2 - .NET Core 3.0 app in AKS

> Walkthrough [Kube manifest for To-Do List](./apps/todo-list/todo-list-web.yml)

Verify cluster:

```
kubectl get nodes
```

Verify apps:

```
kubectl get all
```

Verify secrets:

```
kubectl get secrets
```

Deploy:
```
kubectl apply -f ./todo-list/todo-list.yml
```

Verify again:

```
kubectl get all
```

> Browse to  http://52.249.204.251:8081

## Demo 2 - .NET Framework app

> Walkthrough [Dockerfile](https://github.com/sixeyed/docker-on-windows/blob/master/ch03/ch03-nerd-dinner-web/Dockerfile.v2)

> Walkthrough [Kube manifest for Nerd Dinner](./apps/nerd-dinner-web.yml)

Check secret:

```
kubectl describe secret nerd-dinner-config
```

Deploy:

```
kubectl apply -f ./nerd-dinner/nerd-dinner-web.yml
```

Check:

```
kubectl get all
```

> Browse to http://52.255.212.32:8080/

## Extras

Logs:

```
kubectl get pods

kubectl logs...
```

Dashboard:

```
az aks browse --resource-group dotnetconf2019 --name dotnetconf-aks
```

- Services
- Deployments
- Pods
- Secrets
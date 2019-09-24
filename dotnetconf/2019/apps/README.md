# Sample .NET Apps

A couple of samples to get started on your mixed Linux & Windows Kubernetes cluster.

## To-Do List (.NET Core Blazor app on Linux)

Another annoying todo list app. Running in a Linux pod and connecting to a Postgres database in Azure.

> This version is from the [Chapter 6 source code](https://github.com/sixeyed/diamol/tree/master/ch06/exercises/todo-list) of my book [Learn Docker in a Month of Lunches](https://www.manning.com/books/learn-docker-in-a-month-of-lunches)

The todo list usees Postgres for storage, so you need to add your connection string to:

- `./todo-list/secrets/secrets.json`

Deploy the config files as a secret:

```
kubectl create secret generic todo-list-config --from-file=./todo-list/secrets/config.json --from-file=./todo-list/secrets/secrets.json
```

Deploy the app:

```
kubectl apply -f ./todo-list/
```

Get the the node port for the service:

```
kubectl get svc todo-list-web
```

Browse to the port and you'll see the homepage:

> TODO :)

## Nerd Dinner (ASP.NET MVC app on Windows)

The legendary ASP.NET demo app. Running in a Windows pod and connecting to a SQL Server database in Azure.

> This version is from the [Chapter 3 source code](https://github.com/sixeyed/docker-on-windows/tree/second-edition/ch03) of my book [Docker on Windows](https://amzn.to/2yxcQxN)

Nerd Dinner uses Bing Maps, IP INfo DB and SQL Server, so for full functionality you need to add your keys and connection strings to:

- `./nerd-dinner/secrets/appSettings.config`
- `./nerd-dinner/secrets/connectStrings.config`

Deploy the config files as a secret:

```
kubectl create secret generic nerd-dinner-config --from-file=./nerd-dinner/secrets/appSettings.config --from-file=./nerd-dinner/secrets/connectionStrings.config
```

Deploy the app:

```
kubectl apply -f ./nerd-dinner/
```

Get the the node port for the service:

```
kubectl get svc nerd-dinner-web
```

Browse to the port and you'll see the homepage:

![Nerd Dinner web app](./images/nerd-dinner.png)
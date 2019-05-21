## Pre-reqs

Set up a hybrid EE cluster with Linux and Windows nodes.

Simplest is using Azure Marketplace - https://dockr.ly/ee-azure.

## Setup 

Open:

- Docker - Linux containers
- Terminal
- VS Code with app manifests
- VS Code with voting app
- VS Code with dwwx
- Firefox @ UCP & DTR

### YAML files at

C:\scm\github\sixeyed\presentations\techorama\2018-nl\01-why-containers-will-take-over-the-world\apps

## Demo 1 - Cloud Migration

Deploy `vote-stack.yml`.

Browse to http://sdd193-lin.westeurope.cloudapp.azure.com:5000

Browse to http://sdd193-lin.westeurope.cloudapp.azure.com:5001

Choose Cats, then Dogs.


## Demo 2 - Cloud-Native App

Deploy `sockshop-stack.yml`

Scale front-end

Browse to http://sdd193-lin.westeurope.cloudapp.azure.com:8020


## Demo 3 - Traditional App

Deploy `signup-stack-v1.yml`.

Browse to http://sdd193-win.westeurope.cloudapp.azure.com:8085/app

> Browse containers, check logs & connect - SQL Server & vote 

Deploy `signup-stack-v2.yml`.

Traefik at http://sdd193-lin.westeurope.cloudapp.azure.com:8090

Browse to http://signup.sixeyed.com



## Demo 4 - Serverless

Deploy `fn-stack.yml`.

Check API:

```
curl http://sdd193-lin.westeurope.cloudapp.azure.com:8070
```

Configure client:

```
fn create context `
 --provider default `
 --api-url http://sdd193-lin.westeurope.cloudapp.azure.com:8070 `
 --registry dtrapp-sdd193-x1zd.westeurope.cloudapp.azure.com/functions `
 sdd193

 fn use context sdd193
```

Create function:

```
fn init --runtime python --trigger http hello
```

Deploy:

```
fn create app sdd19

fn --verbose deploy --app sdd19
```

Test:

```
curl  http://sdd193-lin.westeurope.cloudapp.azure.com:8070/t/sdd193/hello-trigger
```

Check image in DTR

https://dtrapp-sdd193-x1zd.westeurope.cloudapp.azure.com/repositories/functions/hello/info


> Update function & redeploy

## Extras

Switch context to UCP in terminal

- Browse stacks
- Browse services
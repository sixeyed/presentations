## Pre-reqs

Set up a hybrid EE cluster with Linux and Windows nodes.

Simplest is using Azure Marketplace - https://dockr.ly/ee-azure.

## Setup 

Run `setup` script to set directory & switch context to UCP.

Open:

- 1x terminal connected to UCP
- 1x VS Code with app manifests
- 1x Firefox

### YAML files at

C:\scm\github\sixeyed\presentations\techorama\2018-nl\01-why-containers-will-take-over-the-world\apps

## Demo 1 - Cloud Migration

Deploy `vote-stack.yml`.

Browse to http://sdd19-lin.westeurope.cloudapp.azure.com:5000

Browse to http://sdd19-lin.westeurope.cloudapp.azure.com:5001

Choose Cats.


## Demo 2 - Cloud-Native App

Deploy `sockshop-stack.yml`

Browse to http://sdd19-lin.westeurope.cloudapp.azure.com:8020


## Demo 3 - Traditional App

Deploy `signup-stack-v1.yml`.

Browse to http://sdd19-win.westeurope.cloudapp.azure.com:8085/app

Deploy `signup-stack-v2.yml`.

Traefik at http://sdd19-lin.westeurope.cloudapp.azure.com:8090

Browse to http://sdd19-lin.westeurope.cloudapp.azure.com



## Demo 4 - Serverless

Deploy `fn-stack.yml`.

Create function:

```
fn init --runtime python --trigger http hello
```

Deploy:

```
fn create app sdd19

fn --verbose deploy --app sdd19
```

Browse to http://ucpapp-sdd19-fk5p.westeurope.cloudapp.azure.com:8070/t/sdd19/hello-trigger
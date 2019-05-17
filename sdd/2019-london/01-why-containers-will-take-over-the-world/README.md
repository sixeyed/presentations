## Pre-reqs

Set up a hybrid EE cluster with Linux and Windows nodes.

Simplest is using Azure Marketplace - https://dockr.ly/ee-azure.

## Setup 

Run `setup` script to set directory & switch context to UCP.

Open:

- 1x iTerm window connected to UCP
- 1x iTerm window SSH to manager
- 1x VS Code with app manifests
- 1x VS Code with mta-netfx-dev code
- 1x Postman with Nuclio collection
- 1x Firefox

### YAML files at

C:\scm\github\sixeyed\presentations\techorama\2018-nl\01-why-containers-will-take-over-the-world\apps

## Demo 1 - Cloud Migration

Deploy `vote-stack.yml`.

Browse to http://linapp-scee-gq8z.centralus.cloudapp.azure.com:5000

Browse to http://linapp-scee-gq8z.centralus.cloudapp.azure.com:5001

Choose Cats.


## Demo 2 - Cloud-Native App

Deploy `sockshop-stack.yml`

Browse to http://linapp-scee-gq8z.centralus.cloudapp.azure.com:8080


## Demo 3 - Traditional App

Deploy `signup-stack-v1.yml`.

Browse to http://winapp-scee-myqc.centralus.cloudapp.azure.com:8085/app

Deploy `signup-stack-v2.yml`.

Browse to http://winapp-scee-myqc.centralus.cloudapp.azure.com:8085



## Demo 4 - Serverless

SSH to manager and run Nuclio:

```
ssh -i ~/.ssh/id_dac2 ubuntu@scee-ucp.centralus.cloudapp.azure.com

sudo docker run -p 8070:8070 --rm \
 --name nuclio \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v /tmp:/tmp \
 nuclio/playground:stable-amd64
```

Browse to http://scee-ucp.centralus.cloudapp.azure.com:8070/, deploy Node JS function, call with Postman.

## Pre-reqs

Set up a hybrid EE cluster with Linux and Windows nodes.

Simplest is using Azure Marketplace - https://dockr.ly/ee-azure.

Set directory & switch context to UCP:

```
cd /Users/elton/ucp/ub1604-01/bundle

eval "$(<env.sh)"

cd /Users/elton/scm/github/sixeyed/presentations/devsum/devsum18-why-containers-take-over-world/apps
```

## Setup

* 1x iTerm window connected to UCP
* 1x Ubuntu window SSH to manager
* 1x VS Code with app manifests
* 1x VS Code with mta-netfx-dev code
* 1x Postman with Nuclio collection
* 1x Firefox

## Demo 1 - Cloud-Native App

Deploy Sock Shop:

```
docker stack deploy -c sockshop-stack.yml sockshop
```

Browse to http://ub1604-01:8080/

## Demo 2 - Traditional App

Deploy SignUp v1 - a .NET 3.5 WebForms app:

```
docker stack deploy -c signup-stack-v1.yml signup
```

Browse to http://win2016-01:8085/

Now deploy update - .NET 4.7 app with EDA and new front-end:

```
docker stack deploy -c signup-stack-v4.yml signup
```

Browse to http://win2016-01:8085/, input data, check logs for app & save handler.

## Demo 3 - Serverless

SSH to manager and run Nuclio:

```
sudo docker run -p 8070:8070 -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp nuclio/playground:stable-amd64
```

Browse to http://ub1604-01:8070/, deploy Node JS function, call with Postman.


# DockerCon 2020

From Fortran on the Desktop to Kubernetes in the Cloud: 
a Windows Migration Story 

> Source code is all in [sixeyed/pi](https://github.com/sixeyed/pi)

## Pre-reqs

Docker Desktop (Windows) - Linux containers, Kubernetes enabled.

## Setup

- Clean Kube instance
- Terminal
- VS Code with this repo

# Demo 1

Dockerizing the compute module and running in different platforms.

## Demo 1.1 - Windows compute

- Walk through [Dockerfile](docker/win/Dockerfile)

> Switch to Windows containers

```
docker run sixeyed/pi:win-dc20

docker run sixeyed/pi:win-dc20 -dp 100
```

And in ACI:

```
az container create `
  -g dc20 `
  --name pi-win-5000 `
  --os-type Windows `
  --cpu 1 `
  --memory 2 `
  --no-wait `
  --image sixeyed/pi:win-dc20 `
  --restart-policy Never `
  --command-line '/app/Pi.Runtime.NetFx -dp 5000'
```

```
az container create `
  -g dc20 `
  --name pi-win-250000 `
  --os-type Windows `
  --cpu 4 `
  --memory 16 `
  --no-wait `
  --image sixeyed/pi:win-dc20 `
  --restart-policy Never `
  --command-line '/app/Pi.Runtime.NetFx -dp 250000'
```

Understand the timing problems:

```
docker image ls sixeyed/pi:win-dc20
```

> Check [Azure Portal](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.ContainerInstance%2FcontainerGroups)

## Demo 1.2 - Linux stub

- Walk through [stub Dockerfile](docker/stub/Dockerfile) and [script](docker/stub/Pi.Runtime.NetFx).

> Switch to Linux containers

```
docker run sixeyed/pi:stub-dc20

docker run sixeyed/pi:stub-dc20 -dp 100
```

And in ACI:

```
az container create `
  -g dc20 `
  --name pi-stub-10000 `
  --os-type Linux `
  --cpu 1 `
  --memory 0.5 `
  --no-wait `
  --image sixeyed/pi:stub-dc20 `
  --restart-policy Never `
  --command-line '/app/Pi.Runtime.NetFx -dp 10000'
```

The stub fixes the speed issue:

```
docker image ls sixeyed/pi:stub-dc20
```

## Demo 1.3 - Kubernetes Job

And flexibility - running Linux-only version in Kubernetes: [pi-job.yaml](kubernetes/jobs/pi-job.yaml)

```
kubectl get nodes

kubectl apply -f kubernetes/jobs/pi-job.yaml

kubectl get po -l job-name=pi-stub-5000

kubectl logs -l job-name=pi-stub-5000
```

Or in a hybrid cluster with Windows nodes using [pi-job-win.yaml](kubernetes/jobs/pi-job-win.yaml)

> Switch context to AKS

```
kubectl get nodes

kubectl apply -f kubernetes/jobs/pi-job-win.yaml

kubectl get po -l job-name=pi-win-100000

kubectl logs -l job-name=pi-win-100000
```

In an AKS cluster, you can burst jobs out to ACI:

- [pi-job-aci.yaml](kubernetes/jobs/pi-job-aci.yaml)
- [pi-job-aci-win.yaml](kubernetes/jobs/pi-job-aci-win.yaml)

# Demo 2

Encapsulating the compute module in a REST API.

## Demo 2.1 - API in Docker to Docker compute

> Switch to Windows containers

Run the Pi API [using the Docker processor](https://github.com/sixeyed/pi/blob/master/src/Pi.Api/appsettings.json):

```
docker run -d -p 8314:80 -v \\.\pipe\docker_engine:\\.\pipe\docker_engine sixeyed/pi:api-win-2002
```

Test it out:

```
curl -X POST http://localhost:8314/jobs --header 'Content-Type: application/json' --data-raw '{\"decimalPlaces\": 700}'

docker logs <processingId>
```

## Demo 2.2 - API in local Kube, stub compute

> Switch to Linux containers

> Switch context to local

Run the Pi API [using Kubernetes Jobs and the Linux stub](kubernetes/api/local/pi-api-configMap.yaml):

```
kubectl apply -f kubernetes/api/local/

kubectl apply -f kubernetes/api/

kubectl get all
```

Test it out:

```
curl -X POST http://localhost:8083/jobs --header 'Content-Type: application/json' --data-raw '{\"decimalPlaces\": 100}'

kubectl get jobs <processingId>

kubectl logs -l job-name=<processingId>
```

## Demo 2.2 - API in AKS, Windows compute

> Switch context to AKS

Run the Pi API [using Kubernetes Jobs and the Windows image](kubernetes/api/azure/pi-api-configMap.yaml):

```
kubectl get nodes

kubectl apply -f kubernetes/api/azure/

kubectl apply -f kubernetes/api/

kubectl get all
```

Test in Azure:

```
kubectl get svc pi-api -o jsonpath='http://{.status.loadBalancer.ingress[0].*}:8083/jobs'

curl -X POST $(kubectl get svc pi-api -o jsonpath='http://{.status.loadBalancer.ingress[0].*}:8083/jobs') --header 'Content-Type: application/json' --data-raw '{\"decimalPlaces\": 10000}'

kubectl get jobs <processingId>

kubectl logs -l job-name=<processingId>
```

# Teardown

```
kubectl delete all -l demo=dc20

kubectl delete jobs -l com.pi=1

kubectl delete clusterrolebinding -l demo=dc20

kubectl delete clusterrole -l demo=dc20

kubectl delete serviceaccount -l demo=dc20
```
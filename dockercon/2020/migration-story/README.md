
## Pre-reqs

Docker Desktop (Windows) - Linux containers, Kubernetes enabled.

## Setup

- Clean Kube instance
- Terminal
- VS Code with this repo

## Demo 1.1 - Windows compute

- Walk through [Dockerfile](./docker/Dockerfile)

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

## Demo 1.2 - Linux stub

- Walk through [Dockerfile.stub](./docker/Dockerfile.stub)

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

## Demo 1.3 - Kubernetes Job

- [pi-job.yaml](kubernetes/jobs/pi-job.yaml)

```
kubectl apply -f kubernetes/jobs/pi-job.yaml

kubectl get po -l job-name=pi-stub-5000

kubectl logs -l job-name=pi-stub-5000
```

In an AKS cluster, you can burst jobs out to ACI:

- [pi-job-aci.yaml](kubernetes/jobs/pi-job-aci.yaml)
- [pi-job-aci-win.yaml](kubernetes/jobs/pi-job-aci-win.yaml)


## Demo 2.1 - API in Docker to Docker compute

> Switch to Windows containers

Run the Pi API:

```
docker run -d -p 8314:80 -v \\.\pipe\docker_engine:\\.\pipe\docker_engine sixeyed/pi:api-2002
```

Test it out:

```
curl -X POST http://localhost:8314/jobs --header 'Content-Type: application/json' --data-raw '{\"decimalPlaces\": 700}'

docker logs <processingId>
```

## Demo 2.2 - API in local Kube, stub compute

> Switch to Linux containers

Run the Pi API:

```
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

...
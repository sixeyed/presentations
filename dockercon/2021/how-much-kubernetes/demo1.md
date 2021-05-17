# Demo 1: Pods

The [Pod](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.20/#pod-v1-core) is the basic unit of compute in Kubernetes. Pods run containers - it's their job to ensure the container keeps running.

Pod specs are very simple. The minimal YAML needs some metadata, and the name of the container image to run.

## Run a simple Pod

- [whoami-pod.yaml](pods/whoami-pod.yaml) is the Pod spec for a simple web app

```
kubectl apply -f pods/whoami-pod.yaml
```

Check pod details:

```
kubectl get pods

kubectl describe pod whoami
```

## Working with Pods

Print the container logs:

```
kubectl logs whoami
```

This container image doesn't have a shell installed; deploy another app:

- [sleep-pod.yaml](pods/sleep-pod.yaml) runs an app which does nothing

```
kubectl apply -f pods/sleep-pod.yaml

kubectl get pods
```

This Pod container does have a shell, you can connect and explore the environment:

```
kubectl exec -it sleep -- hostname

kubectl exec -it sleep -- whoami
```

## Connecting from one Pod to another

Print the IP address of the whoami Pod:

```
kubectl get pods -o wide
```

> That's the internal IP address of the Pod - any other Pod in the cluster can connect on that address

Make a request to the HTTP server in the whoami Pod from the sleep Pod:

```
kubectl exec sleep -- curl -s <whoami-pod-ip>
```

> The output is the response from the whoami server - it includes the  hostname and IP addresses
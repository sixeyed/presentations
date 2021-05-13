# Demo 1: Pods

The [Pod](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.20/#pod-v1-core) is the basic unit of compute in Kubernetes. Pods run containers - it's their job to ensure the container keeps running.

Pod specs are very simple. The minimal YAML needs some metadata, and the name of the container image to run.

## Run a simple Pod

- [whoami-pod.yaml](pods/whoami-pod.yaml) is the Pod spec for a simple web app

```
kubectl apply -f pods/whoami-pod.yaml
```

Or the path to the YAML file can be a web address:

```
kubectl apply -f https://k8sfun.courselabs.co/labs/pods/specs/whoami-pod.yaml
```

> The output shows you that nothing has changed. Kubernetes works on **desired state** deployment

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

Connect to the container inside the Pod:

```
kubectl exec -it whoami -- sh
```

> This container image doesn't have a shell installed!

Deploy another app:

- [sleep-pod.yaml](pods/sleep-pod.yaml) runs an app which does nothing

```
kubectl apply -f pods/sleep-pod.yaml

kubectl get pods
```

This Pod container does have a shell, you can connect and explore the environment:

```
kubectl exec -it sleep -- sh

hostname

whoami

exit
```

## Reliability in Pods

The Pod's role is to manage the container. If the container exits, the Pod creates a replacement.

Kill the sleep container process, and check the Pod status:

```
kubectl exec sleep -- kill 1

kubectl get pods
```

> The sleep Pod has been restarted - that means it has a new container

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
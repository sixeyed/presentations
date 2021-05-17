# Demo 2: Services

Every Pod has an IP address which other Pods in the cluster can reach, but that IP address only applies for the life of the Pod.

Services provide a consistent IP address linked to a DNS name, and you'll always use Services for routing internal and external traffic into Pods.

Services and Pods are loosely-coupled: a Service finds target Pods using a [label selector](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/).

## Run sample Pods

Replace the Pods from the previous demo with new definitions which contain labels:

* [whoami.yaml](services/pods/whoami.yaml)
* [sleep.yaml](services/pods/sleep.yaml)

```
kubectl delete pods whoami sleep

kubectl apply -f services/pods/
```

> You can work with multiple objects and deploy multiple YAML manifests with Kubectl

Print Pod details, complete with labels:

```
kubectl get pods -o wide --show-labels
```

## Deploy an internal Service

Kubernetes provides different types of Service for internal and external access to Pods. 

[ClusterIP](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/) is the default and it means the Service gets an IP address which is only accessible within the cluster - its for components to communicate internally.

* [whoami-clusterip.yaml](services/whoami-clusterip.yaml) defines a ClusterIP service which routes traffic to the whoami Pod

```
kubectl apply -f services/whoami-clusterip.yaml
```

Print the details:

```
kubectl describe svc whoami
```

> The endpoint list shows the IP of the whoami Pod

## Communicating between Pods with Services

Kubernetes runs a DNS server inside the cluster and every Service gets an entry, linking the IP address to the Service name.

```
kubectl exec sleep -- nslookup whoami

kubectl exec sleep -- curl -s http://whoami
```

> When the Pod gets replaced, the communication will still work - the Service is decoupled from the Pod

## Deploy an external Service

[LoadBalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/) Services establish network communication to Pods from outside the cluster:

* [whoami-loadbalancer.yaml](services/whoami-loadbalancer.yaml)

```
kubectl apply -f services/whoami-loadbalancer.yaml

kubectl get svc
```

> The whoami Services all have the same label selector, so they all direct traffic to the same Pod

Now you can call the whoami app from your local machine:

```
curl http://localhost:8080
```

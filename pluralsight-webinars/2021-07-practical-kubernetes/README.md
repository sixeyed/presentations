# Practical Kubernetes

To follow along with the demos you need a Kubernetes cluster.

A simple dev environment is fine:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) on Windows or Mac **OR** [Docker Engine](https://hub.docker.com/search?offering=community&operating_system=linux&q=&type=edition) on Linux
- [K3d](https://k3d.io) - a lightweight Kubernetes distro which runs a cluster in Docker containers

I use this for the demos:

```
k3d cluster create k8sdemo -p "30000-30040:30000-30040@server[0]"
```

## Demo 1 - Rolling updates

_Check the cluster:_

```
kubectl get nodes
```

Simple app:

- [whoami-v1.yaml](./demo1/whoami-v1.yaml) - Deployment
- [whoami-nodeport.yaml](./demo1/whoami-nodeport.yaml) - Service

_Deploy and print info:_

```
kubectl apply -f demo1/

kubectl get po --show-labels -o wide

kubectl describe svc whoami-np
```

_Try the app:_

```
curl localhost:30010
```

> Repeat - requests are load-balanced

Update:

- [whoami-v2.yaml](./demo1/update-v2/whoami-v2.yaml) - config change & rollout settings

```
kubectl apply -f demo1/update-v2

kubectl get po -l app=whoami --watch

kubectl get endpoints whoami-np
```

_Try v2:_

```
curl localhost:30010
```

> Repeat - new config & requests load-balanced

Bad update:

- [whoami-v3.yaml](./demo1/update-v3/whoami-v3.yaml) - image does not exist

```
kubectl apply -f demo1/update-v3

kubectl get po -l app=whoami --watch
```

> v2 Pods taken down but new v3 Pods in `ErrImagePull` status

```
kubectl get replicaset

kubectl get po -l app=whoami
```

_Try the app:_

```
curl localhost:30010
```

> Reduced capacity, but still running at v2 spec

_Rollback:_

```
kubectl rollout undo deployment/whoami

kubectl get replicaset

kubectl get po -l app=whoami
```

> Back to full capacity at v2 spec

## Demo 2 - RBAC

Sepc to run Kubectl inside a Pod:

- [01-namespace.yaml](./demo2/01-namespace.yaml) - namespace for the demo
- [02-serviceaccount.yaml](./demo2/02-serviceaccount.yaml) - service account for the Pod
- [kubectl-pod.yaml](./demo2/kubectl-pod.yaml) - Pod with Kubectl installed, using custom SA
- [configmap.yaml](./demo2/configmap.yaml) - a ConfigMap we want to see inside the Pod
- [secret.yaml](./demo2/secret.yaml) - a Secret we don't want the Pod to see

_Deploy:_

```
kubectl apply -f demo2/

kubens

kubens rbac-demo

kubectl get po
```

> [Kubens and Kubectx](https://kubectx.dev/) are great tools for working with multiple clusters and namespaces

_Connect to the Pod container and use Kubectl:_

```
kubectl exec -it kubectl -- sh

ls /var/run/secrets/kubernetes.io/serviceaccount

cat /var/run/secrets/kubernetes.io/serviceaccount/token

kubectl config set-credentials user --token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

kubectl get all

kubectl get cm -n rbac-demo

exit
```

> Authorization needs to be explicitly granted, new SAs start with no access

RBAC:

- [role.yaml](./demo2/rbac/role.yaml) - grant access to ConfigMaps in the demo ns
- [rolebinding.yaml](./demo2/rbac/rolebinding.yaml) - assign role to the Kubectl Pod SA

_Apply RBAC:_

```
kubectl apply -f demo2/rbac
```

> Rules evaluated on-demand, no need to restart Pods

_Use Kubectl in the Pod:_

```
kubectl exec -it kubectl -- sh

kubectl get cm -n rbac-demo

kubectl get cm -n rbac-demo -o json

kubectl get secrets,pods -n rbac-demo

kubectl get cm -n default
```

> Only ConfigMaps in the ns can be accessed, all other objects and other ns are blocked

## Demo 3 - Ingress

Ingress controller:

- [daemonset.yaml](./demo3/ingress-controller/daemonset.yaml) - DaemonSet to run the controller Pod
- [02_rbac.yaml](./demo3/ingress-controller/02_rbac.yaml) - RBAC for controller to access Kubernetes API

_Switch to default ns & deploy:_

```
kubens -

kubectl apply -f demo3/ingress-controller/

kubectl get svc -n ingress-nginx
```

_Check ngress controller is listening:_

```
curl localhost:30000
```

> Default 404 if no rules match the incoming request

Ingress rule for the whoami app:

- [whoami/ingress.yaml](./demo3/whoami/ingress.yaml) - routes `whoami.local` requests to whoami Service

_Deploy and test:_

```
kubectl apply -f demo3/whoami/

kubectl get ingress

cat C:/windows/system32/drivers/etc/hosts

curl whoami.local:30000
```

And for a new Pi app:

- [pi/ingress.yaml](./demo3/pi/ingress.yaml) - routes `pi.local` to the ClusterIP Service, using Nginx response cache

_Deploy:_

```
kubectl apply -f demo3/pi/

kubectl get ingress
```

> Try the app at http://pi.local:30000/pi?dp=60000

> Calculation takes about 4sec on my machine; refresh - the response is from the cache, no calculation time

## Demo 4 - Production readiness

Security concerns:

- [security/pi.yaml](./demo4/security/pi.yaml) - add resource limits, security context and app setup to run as non-root

_Update the Pi app:_

```
kubectl apply -f demo4/security/

kubectl get po -l app=pi-web
```

> Check the new Pods still work http://pi.local:30000/pi?dp=100

_These Pods don't have an SA token:_

```
kubectl exec deploy/pi-web -- cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

Health probes:

- [health/pi.yaml](./demo4/health/pi.yaml) - adds **misconfigured** container probes

_Deploy - the probes stop the rollout:_

```
kubectl apply -f demo4/health/

kubectl get po -l app=pi-web --watch
```

> New Pod running but 0/1 ready

```
kubectl describe po [name]
```

> Container probes are an easy way to break your app

This fixes it - port names are a good best practice:

- [fixed/pi.yaml](./demo4/health/fixed/pi.yaml) - uses a simple TCP port check for liveness and a fast HTTP check for readiness

_Update the deployment:_

```
kubectl apply -f demo4/health/fixed/

kubectl get po -l app=pi-web --watch
```

> Rollout completes - and the app is still working at http://pi.local:30000/pi?dp=300

## Teardown

Remove all objects:

```
kubectl delete all,ns,ingress,svc -l pswebinar=21.07
```

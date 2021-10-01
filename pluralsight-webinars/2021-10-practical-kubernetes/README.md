# Practical Kubernetes

To follow along with the demos you need a Kubernetes cluster.

A simple dev environment is fine:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) on Windows or Mac
- **OR** [Docker Engine](https://hub.docker.com/search?offering=community&operating_system=linux&q=&type=edition) and [k3d](https://k3d.io) on Linux - a lightweight Kubernetes distro which runs a cluster in Docker containers

## Pre-reqs

Use this command if you're using k3d for the demos:

```
k3d cluster create k8sdemo -p "30000-30040:30000-30040@server[0]"
```

**Do this if you use Docker Desktop** *

There's a [bug in the default RBAC setup](https://github.com/docker/for-mac/issues/4774) in Docker Desktop, which means permissions are not applied correctly. If you're using Kubernetes in Docker Desktop, run this to fix the bug:

```
# on Docker Desktop for Mac (or WSL2 on Windows):
sudo chmod +x ./scripts/fix-rbac-docker-desktop.sh
./scripts/fix-rbac-docker-desktop.sh

# OR on Docker Desktop for Windows (PowerShell):
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force
./scripts/fix-rbac-docker-desktop.ps1
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

_New terminal_:

```
kubectl get po -l app=whoami --watch
```

```
kubectl apply -f demo1/update-v2

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

kubectl get endpoints whoami-np
```

> Back to full capacity at v2 spec

## Demo 2 - RBAC

Spec to run Kube Explorer:

- [kube-explorer.yaml](./demo2/kube-explorer.yaml) - Service, ServiceAccount, Deployment

_Deploy:_

```
kubectl apply -f demo2/
```

> Try the app at http://localhost:30012 - 403 error. Authorization needs to be explicitly granted, new SAs start with no access.

_But the app is authenticated, from the SA token which Kubernetes mounts:_

```
kubectl exec deploy/kube-explorer -- cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

Namespaced RBAC:

- [pod-manager.yaml](./demo2/rbac/namespace/pod-manager.yaml) - grant update access to Pods in the default ns

_Apply RBAC:_

```
kubectl apply -f demo2/rbac/namespace/
```

> Refresh http://localhost:30012 - can now list & delete Pods; rules evaluated on-demand, no need to restart Kube Explorer app

> Only for default namespace -try http://localhost:30012?ns=kube-system

Cluster-wide RBAC:

- [pod-reader.yaml](./demo2/rbac/cluster/pod-reader.yaml) - grant read access to Pods in all namespaces

_Apply RBAC:_

```
kubectl apply -f demo2/rbac/cluster/
``` 

> Refresh http://localhost:30012?ns=kube-system - can view but not delete

## Demo 3 - Ingress

Ingress controller:

- [daemonset.yaml](./demo3/ingress-controller/daemonset.yaml) - DaemonSet to run the controller Pod
- [02_rbac.yaml](./demo3/ingress-controller/02_rbac.yaml) - RBAC for controller to access Kubernetes API

_Deploy controller:_

```
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

- [health/pi.yaml](./demo4/health/pi.yaml) - adds **misconfigured** container probes, and aggressive rollout

_New terminal:_

```
kubectl get po -l app=pi-web --watch
```

_Deploy - the old Pods are replaced but the new ones never come online:_

```
kubectl apply -f demo4/health/
```

> New Pods running but 0/1 ready & restarting

```
kubectl get endpoints pi-internal

kubectl describe po [name]
```

> No Pods in the Service, not ready; also failing livenes and restarting - CrashLoopBackOff.

Container probes are an easy way to break your app, if your rollout settings are too aggressive

## Teardown

Remove all objects:

```
kubectl delete all,ingress,rolebinding,clusterrolebinding,role,clusterrole,serviceaccount,ns -l pswebinar=21.10
```

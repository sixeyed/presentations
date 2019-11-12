# Demo 1 - install & use Istio

> Adapted from the [Istio Quick Start](https://istio.io/docs/setup/kubernetes/quick-start/)

## 1.0 Installation

Install CRDs:

```
kubectl apply -f 01_crds.yaml
```

Deploy Istio:

```
kubectl apply -f 02_istio.yaml
```

Configure ns for auto sidecar injection:

```
kubectl label namespace default istio-injection=enabled
```

## 1.1 Verify Istio

Running objects:

```
kubectl get all

kubectl get all -n istio-system
```

Check label:

```
kubectl describe namespace default 
```

## 1.2 Deploy app

Deploy Bookinfo:

```
kubectl apply -f 03_bookinfo-v1.yaml
```

Check services:

```
kubectl get svc

kubectl get svc istio-ingressgateway -n istio-system
```

> Browse to http://localhost/productpage & refresh, load-balancing across review svc

Check pods have proxy auto-injected

```
kubectl describe pods --selector app=productpage
```
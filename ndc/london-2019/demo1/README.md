# Demo 1 - install & use Istio

> Adapted from the [Istio Quick Start](https://istio.io/docs/setup/kubernetes/quick-start/)

## 1.1 Installation

Install CRDs:

```
kubectl apply -f 01_crds.yaml
```

Deploy Istio:

```
kubectl apply -f 02_istio.yaml
```

Verify:

```
kubectl get all -n istio-system
```

Configure ns for auto sidecar injection:

```
kubectl label namespace default istio-injection=enabled
```

Deploy Bookinfo:

```
kubectl apply -f 03_bookinfo.yaml
```

Deploy ingress gateway:

```
kubectl apply -f 04_bookinfo-gateway.yaml

```

Check:

```
kubectl get svc istio-ingressgateway -n istio-system
```

Browse to http://localhost/productpage & refresh, load-balancing across review svc

> Check pods have proxy auto-injected
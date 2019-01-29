

## Demo 1 - install Istio & depoloy sample app

> Adapted from the [Istio Quick Start](https://istio.io/docs/setup/kubernetes/quick-start/)

Install CRDs:

```
kubectl apply -f demo1/crds.yaml
```

Deploy Istio:

```
kubectl apply -f demo1/istio-demo-auth.yaml
```

Verify:

```
kubectl get svc -n istio-system
```

```
kubectl get pods -n istio-system
```

Configure ns for auto sidecar injection:

```
kubectl label namespace default istio-injection=enabled
```

Deploy Bookinfo:

```
kubectl apply -f demo1/bookinfo.yaml
```

Deploy ingress gateway:

```
kubectl apply -f demo1/bookinfo-gateway.yaml

```
# Demo 1 - install & use Istio

> Adapted from the [Istio Quick Start](https://istio.io/docs/setup/kubernetes/quick-start/)

## 1.1 Verify Istio

Running objects:

```
kubectl get all -n istio-system
```

Label:

```
kubectl describe namespace default 
```

## 1.2 Deploy app

Deploy Bookinfo:

```
kubectl apply -f 03_bookinfo.yaml
```

Check:

```
kubectl get svc istio-ingressgateway -n istio-system
```

Browse to http://localhost/productpage & refresh, load-balancing across review svc

> Check pods have proxy auto-injected
# Demo setup - install & use Istio

> Adapted from the [Istio Quick Start](https://istio.io/docs/setup/kubernetes/quick-start/)

## Installation

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

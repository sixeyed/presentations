
# Demo 3 - security & observability

Check default mesh policy is MTLS:

```
kubectl describe meshpolicy default
```


# Demo 4 - observability

## 4.1 - service graph

Port-forward:

```
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}') 8088:8088
```

> Browse to http://localhost:8088/force/forcegraph.html


## 4.2 - tracing

Port-forward:

```
kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686
```

> Browse to http://localhost:16686

( requires X-* headers)

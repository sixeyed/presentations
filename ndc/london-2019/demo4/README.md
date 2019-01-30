

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

## 4.3 - performance

Port-forward:

```
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000
```

> Browse to http://localhost:3000


## 4.4 - logging

> Adapted from [Istio's Logging with Fluentd](https://istio.io/docs/tasks/telemetry/fluentd/)

Deploy FLuentd, ElasticSearch & Kibana:

```
kubectl apply -f 01_logging-stack.yaml
```

Configure logging for demo app:

```
kubectl apply -f 02_fluentd-istio.yaml
```

Port-forward Kibana:

```
kubectl -n logging port-forward $(kubectl -n logging get pod -l app=kibana -o jsonpath='{.items[0].metadata.name}') 5601:5601
```

> Browse to http://localhost:5601 (index pattern `*`, time filter fiels `@timestamp`)
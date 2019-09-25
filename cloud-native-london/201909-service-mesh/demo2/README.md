
# Demo 2 - traffic management

> Adapted from the [Istio Traffic Management samples](https://istio.io/docs/tasks/traffic-management/)

Deploy v2 for the test team:

```
kubectl apply -f 01_bookinfo-v2.yaml
```

Deploy v3 for test team:

```
kubectl apply -f 02_bookinfo-v3.yaml
```

03 - Test error handling - slow response

04 - Test error handling - server failure:

Canary rollout - 80/20:

```
kubectl apply -f 05-staged-rollout.yaml
```

Full deployment:

```
kubectl apply -f 06-v3.yaml
```

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

Test error handling - slow response

```
kubectl apply -f 03_delay-test.yaml
```

Test error handling - server failure:

```
kubectl apply -f 04_fault-test.yaml
```

Canary rollout - 80/20:

```
kubectl apply -f 05-staged-rollout.yaml
```

Full deployment:

```
kubectl apply -f 06-v3.yaml
```
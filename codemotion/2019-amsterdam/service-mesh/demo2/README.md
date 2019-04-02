
# Demo 2 - traffic management

> Adapted from the [Istio Traffic Management samples](https://istio.io/docs/tasks/traffic-management/)

Set up routing rules:

```
kubectl apply -f 01_destination-rule.yaml
```

Route to reviews v1:

```
kubectl apply -f 02_virtual-service-reviews-v1.yaml
```

Verify:

```
kubectl get virtualservice reviews -o yaml
```

Route to v2 for tester:

```
kubectl apply -f 03_virtual-service-reviews-test-v2.yaml
```

Test error handling - slow response:

```
kubectl apply -f  04_virtual-service-ratings-test-delay.yaml
```

Test error handling - server failure:

```
kubectl apply -f  05_virtual-service-ratings-test-abort.yaml
```

Canary rollout - 80/20:

```
kubectl apply -f 06_virtual-service-reviews-v2-v3.yaml
```

Full deployment:

```
kubectl apply -f 07_virtual-service-reviews-v3.yaml
```
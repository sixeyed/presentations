
# Demo 3 - security

> Adapted from the [Istio Mutual TLS Deep-Dive](https://istio.io/docs/tasks/security/mutual-tls/)


> Use Ubuntu...

Check default mesh policy is MTLS:

```
kubectl describe meshpolicy default
```

Now find a running Istio container:

```
docker container ls --filter name=istio-proxy_productpage
```

Get its ID:

```
id=$(docker container ls --filter name=istio-proxy_productpage --format '{{ .ID}}')
```

List certs:

```
docker container exec $id ls /etc/certs
```

Check dates:

```
docker container exec $id cat /etc/certs/cert-chain.pem | openssl x509 -text -noout  | grep Validity -A 2
```

Check name:

```
docker container exec $id cat /etc/certs/cert-chain.pem | openssl x509 -text -noout  | grep 'Subject Alternative Name' -A 1
```

Check Istio rules:

```
istioctl authn tls-check details.default.svc.cluster.local
```

Try and connect with http:

```
docker container exec $id curl http://details:9080
```

Try and connect with https but without client cert:

```
docker container exec $id curl https://details:9080
```

Connect with https and client cert:

```
docker container exec $id curl https://details:9080 --key /etc/certs/key.pem --cert /etc/certs/cert-chain.pem --cacert /etc/certs/root-cert.pem -k
```

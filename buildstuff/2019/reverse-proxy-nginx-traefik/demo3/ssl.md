
Self-signed cert for demo use.

Created with:

```
openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out blog-local.crt -keyout blog-local.key
```

```
chmod 400 blog-local.key
````

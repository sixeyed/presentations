#

## Demo 1 - Nginx proxy cache

Pi app direct

```
docker container run -d -p 80:80 --name pi sixeyed/pi-web:1911
```

> Browse to http://localhost and http://localhost?dp=1000 etc.

- no caching
- no gzip

Pi app with Nginx

- Walk through [Nginx configuration](demo1/nginx.conf) and [Compose file](demo1/docker-compose.yml)

```
docker container rm -f pi

docker-compose -f ./demo1/docker-compose.yml up -d
```

> Repeat http://localhost and http://localhost?dp=1000 with network view (Ctrl-Shift-E)

- response caching
- header rewrite

Kill app container:

```
docker container rm -f demo1_pi_1
```

> http://localhost and http://localhost?dp=1000

Scale up

```
docker-compose -f ./demo1/docker-compose.yml up -d --scale pi=3
```

> http://localhost etc - different hostnames

## Demo 2 - Nginx multiple domains

Todo app direct

```
docker container rm -f $(docker container ls -aq)

docker container run -d -p 80:80 --name todo diamol/ch06-todo-list
```

> Browse to http://localhost

- all paths available

Pi app + todo app

- Walk through [Nginx configuration](demo2/nginx.conf) and [Compose file](demo2/docker-compose.yml)

```
cat C:\Windows\System32\drivers\etc\hosts

docker container rm -f todo

docker-compose -f ./demo2/docker-compose.yml up -d
```

> Browse to http://pi.local and http://todo.local

- http://todo.local/diagnostics unavailable

## Demo 3 - Nginx headers & SSL

Blog direct

```
docker container rm -f $(docker container ls -aq)

docker container run -d -p 2368:2368 --name blog ghost:3.0.2-alpine
```

> Browse to http://localhost:2368

- plain http
- ghost endpoint available

Blog + Pi app + todo app

- Walk through [Nginx configuration](demo3/nginx.conf) and [Compose file](demo3/docker-compose.yml)

```
docker container rm -f blog

docker-compose -f ./demo3/docker-compose.yml up -d
```

> Browse to http://pi.local, http://todo.local and http://blog.local

## Demo 4 - Traefik with Docker

```
docker swarm init

docker stack deploy -c ./demo4/docker-compose.yml apps
```

## Demo 5 - Traefik as Kubernetes ingress

```
docker container rm -f $(docker container ls -aq)

docker swarm leave -f

kubectl apply -f ./demo5/apps

kubectl apply -f ./demo5/traefik.yml

kubectl apply -f ./demo5/ingress.yml
```

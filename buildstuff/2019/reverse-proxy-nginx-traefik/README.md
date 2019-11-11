#

## Demo 1 - Nginx proxy cache

Pi app direct

```
docker container run -d -p 80:80 --name pi sixeyed/pi-web:1911
```

> Browse to http://localhost and http://localhost?dp=1000 etc.

- no caching
- no gzip

```
docker container rm -f pi
```

Pi app with Nginx

```
docker-compose -f ./demo1/docker-compose.yml up -d
```

> Repeat http://localhost and http://localhost?dp=1000 with dev tools

- response caching
- header rewrite

Kill app container:

```
docker rm -f demo1_pi_1
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
docker rm -f $(docker ps -aq)

docker container run -d -p 80:80 --name todo diamol/ch06-todo-list
```

> Browse to http://localhost

- all paths available

Pi app + todo app

```
docker container rm -f todo

docker-compose -f ./demo2/docker-compose.yml up -d
```

> Browse to http://pi.local and http://todo.local

- http://todo.local/diagnostics unavailable

## Demo 3 - Nginx headers & SSL

Blog + Pi app + todo app

```
docker rm -f $(docker ps -aq)

docker-compose -f ./demo3/docker-compose.yml up -d
```

> Browse to http://blog.local, http://pi.local and http://todo.local

## Demo 4 - Traefik with Docker

## Demo 5 - Traefik as Kubernetes ingress

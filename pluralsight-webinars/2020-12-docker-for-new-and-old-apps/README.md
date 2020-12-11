

## Demo 1

> Windows container mode

* [Petshop web Dockerfile](petshop/docker/web/Dockerfile)

```
docker run -p 8080:80 sixeyed/petshop-web:1809
```

Browse to http://localhost:8080 (fails)

> Linux container mode

* [Access Log API Dockerfile](apod/access-log/Dockerfile)

```
docker run -d -p 8030:80 psdockerprod/access-log:m2
```

Browse to http://localhost:8030/stats


* [Access Log API Dockerfile](apod/access-log/Dockerfile)

```
docker run -d --name api -p 8010:80 psdockerprod/image-of-the-day:m2

docker logs api
```

Browse to http://localhost:8010/image

```
docker logs api
```


## Demo 2

> Windows container mode

* [Petshop Docker Compose file](petshop/docker/docker-compose.yml)

```
docker-compose -f ./petshop/docker/docker-compose.yml up -d
```

> Linux container mode

* [APOD Docker Compose file](apod/docker-compose.yml)

```
docker-compose -f ./petshop/docker/docker-compose.yml up -d
```


## Demo 3

TODO - Kubernetes 
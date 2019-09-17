# Docker + Arm: Building multi-arch apps with `buildx`

Demos for the Docker Webinar.

> Watch the recording at https://dockr.ly/arm-webinar

> Sample code is from the book [Learn Docker in a Month of Lunches](https://www.manning.com/books/learn-docker-in-a-month-of-lunches), the source repo is [sixeyed/diamol](https://github.com/sixeyed/diamol).

## Demo 1: Understanding image architecture

Check the engine OS & architecture:

```
docker version
```

Run a container:

```
docker container run diamol/ch02-hello-diamol
```

Inspect the image:

```
docker image inspect diamol/ch02-hello-diamol
```

Get just the os & architecture:

```
docker image inspect --format '{{.Os}}/{{.Architecture}}' diamol/ch02-hello-diamol
```

> Repeat for Win/Linux/Arm/Arm64

Check the image manifest:

```
docker manifest inspect diamol/ch02-hello-diamol
```

_Requires experimental mode in Docker CLI:_

```
cat ~/.docker/config.json
```

Check the image on Docker Hub:

> https://hub.docker.com/r/diamol/ch02-hello-diamol/tags


## Demo 2: Multi-arch the old way

A build farm:

```
docker node ls
```

Build job which loops over each os & architecture:

> http://jenkins.athome.ga/job/diamol/job/ch04-image-gallery/configure

_Or see sample scripts: [build-and-push.sh](./demo2/build-and-push.sh) and [push-manifest.sh](./demo2/push-manifest.sh)_

And sample job output:

> http://jenkins.athome.ga/job/diamol/job/ch04-image-gallery/27/console

_Or see: [build-log.txt](./demo2/build-log.txt)_

Advantage - images can have different contents:

- [diamol/base](https://github.com/sixeyed/diamol/tree/master/images/base)
- [diamol/maven](https://github.com/sixeyed/diamol/tree/master/images/maven)

## Demo 3: Multi-arch with `buildx`

> `buildx` is packaged with Docker Desktop, currently on the Edge channel

Switch to `todo-list` directory:

```
cd /scm/github/sixeyed/diamol/ch06/exercises/todo-list

cat Dockerfile
```

Build on local machine with emulation:

```
docker buildx use default

docker buildx build -t sixeyed/todo-webinar:arm64 --platform linux/arm64 .
```

Create a build farm:

```
docker context ls

docker buildx create --use --name webinar pi3-01

docker buildx create --append --name webinar pine64-01

docker buildx create --append --name webinar up-ub1604

docker buildx ls
```

Build & push using the farm:

```
docker buildx build -t sixeyed/todo-webinar:buildx --platform linux/arm,linux/arm64/linux/amd64 .
```


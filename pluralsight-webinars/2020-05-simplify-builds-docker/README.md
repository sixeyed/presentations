# Demo 1

Quick refresher on Docker and Docker Compose.

## Demo 1.1

Run two containers which are components of the same app:

```
docker network create pi

docker run -d --network pi --name pi-web sixeyed/pi-web:psod-2005

docker run -d --network pi -p 8314:80 sixeyed/pi-proxy:psod-2005
```

> Use the app at http://localhost:8314/pi?dp=1000

## Demo 1.2

Compose lets you define the desired state of your app.

[pi-psod-2005.yml](TODO) describes the same app in a declarative way.

Remove the existing containers:

```
docker rm -f $(docker ps -aq)
```

Deploy again with Compose:

```
docker-compose -f psod-2005.yml up -d
```

> And test at http://localhost:8314/pi?dp=1000

## Demo 1.3

Containers are packaged on top of a base image with the app runtime. 

This should be as small as possible with no unnecessary tools; for Java:

```
docker container run -it --entrypoint sh openjdk:11-jre-slim

java --version

javac --version

exit
```

You can also run a container with a full development environment, like Maven:

```
docker container run -it --entrypoint sh maven:3.6.3-jdk-11

java --version

javac --version

mvn --version

exit
```

And that lets you use Docker as your build environment.

# Demo 2

Multi-stage Dockerfiles let you use different base images for different tasks.

Stage 1 can use an SDK image to compile the app; stage 2 uses the runtime image and copies in the compiled app.

## Demo 2.1

This [Dockerfile for a .NET Core app]() shows how it works.

```
cd D:/scm/github/sixeyed/dak4.net

docker build -t signup-web-core -f ./docker/frontend-web/signup-web-core/Dockerfile .
```

Edit CS and rebuild - mostly from cache.


## Demo 2.2

The concept is the same for other languages - see this [Dockerfile for a .NET Fx app]().

> Switch to Windows containers

```
docker version

docker build -t signup-web -f ./docker/frontend-web/v2/Dockerfile .
```

# Demo 3

## Demo 3.1

```
cd D:/scm/github/sixeyed/diamol

docker-compose build
```

```
docker-compose up -d
```

Check the app at http://localhost:8010

## Demo 3.2

Check the GitHub Actions workflows in the [sixeyed/kiamol]() repository.

> https://github.com/sixeyed/kiamol/actions

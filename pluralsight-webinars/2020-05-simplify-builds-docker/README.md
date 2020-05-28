# Simplify Your Project Builds with Docker

Demos: https://is.gd/obecin

Slides: https://is.gd/rububi

# Demo 1

Quick refresher on Docker and Docker Compose.

> Uses the [sixeyed/pi](https://github.com/sixeyed/pi) repo

## Demo 1.1

Run two containers which are components of the same app.

```
docker network create pi

docker run -d --network pi --name pi-web -e Computation:Metrics:Enabled=false sixeyed/pi:20.05 -m web

docker run -d --network pi -p 8314:80 sixeyed/pi:proxy-20.05
```

> Use the app at http://localhost:8314/pi?dp=5000

## Demo 1.2

Compose lets you define the desired state of your app.

This [docker-compose.yml](./demo1/docker-compose.yml) file describes the same app in a declarative way.

Remove the existing containers:

```
docker rm -f $(docker ps -aq)
```

Deploy again with Compose:

```
docker-compose -f ./demo1/docker-compose.yml up -d

docker ps
```

> And test at http://localhost:8314/pi?dp=10000

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

> Uses the [sixeyed/dak4.net](https://github.com/sixeyed/dak4.net) repo

## Demo 2.1

This [Dockerfile for a .NET Core app](https://github.com/sixeyed/dak4.net/blob/master/docker/frontend-web/signup-web-core/Dockerfile) shows how it works.

```
cd D:/scm/github/sixeyed/dak4.net

docker build -t signup-web-core -f ./docker/frontend-web/signup-web-core/Dockerfile .
```

Edit CS and rebuild - mostly from cache.

```
Add-Content -Value '//' -Path D:\scm\github\sixeyed\dak4.net\src\SignUp.Web.Core\Program.cs

docker build -t signup-web-core -f ./docker/frontend-web/signup-web-core/Dockerfile .
```

## Demo 2.2

The concept is the same for other languages - see this [Dockerfile for a .NET Fx app](https://github.com/sixeyed/dak4.net/blob/master/docker/frontend-web/v2/Dockerfile).

> Switch to Windows containers

```
docker version

docker build -t signup-web -f ./docker/frontend-web/v2/Dockerfile .
```

# Demo 3

You can add build details to Docker Compose files and build all your images with a single command.

> Uses the [sixeyed/diamol](https://github.com/sixeyed/diamol) repo

## Demo 3.1

This [docker-compose.yml](./demo3/docker-compose.yml) file is for a multi-container app with different tech stecs.

> This works with Linux or Windows containers

```
cd D:/scm/github/sixeyed/diamol

docker-compose build

docker-compose build --pull --no-cache
```

Check out the Dockerfiles:

- [Node.js access-log API](https://github.com/sixeyed/diamol/blob/master/ch04/exercises/access-log/Dockerfile)
- [Java REST API](https://github.com/sixeyed/diamol/blob/master/ch04/exercises/image-of-the-day/Dockerfile)
- [Go web app](https://github.com/sixeyed/diamol/blob/master/ch04/exercises/image-gallery/Dockerfile)

Run the app:

```
docker-compose up -d
```

Check the app at http://localhost:8010

## Demo 3.2

Check the GitHub Actions workflows in the [sixeyed/kiamol](https://github.com/sixeyed/kiamol) repository:

- [ch03 build](https://github.com/sixeyed/kiamol/blob/master/.github/workflows/ch03.yaml)
- [ch03 compose file](https://github.com/sixeyed/kiamol/blob/master/ch03/docker-images/docker-compose.yml)
- [ch03 API Dockerfile](https://github.com/sixeyed/kiamol/blob/master/ch03/docker-images/numbers/numbers-api/Dockerfile)
- [ch03 sleep Dockerfile](https://github.com/sixeyed/kiamol/blob/master/ch03/docker-images/sleep/Dockerfile)

> And the live builds at https://github.com/sixeyed/kiamol/actions

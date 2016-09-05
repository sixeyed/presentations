
##Demo 1 - .NET Core

Showing the basics of .NET Core with a Hello World console app:

```
mkdir demo 
cd demo
dotnet new
dotnet restore 
dotnet run
```

Then looking at the Pi app, seeing how the main ASP.NET MVC code is fundamentally the same as the full .NET Framework, but the host is a console app. There are tasks set up for VS Code, so you can hit F5 to run and debug the site. Publishing the app produces all the binaries:

```
cd dotnet\PiWebApp
dotnet publish
```


##Demo 2 - Docker

Starting with the basics of Docker. If you're using Docker for Windows, you can run this on the command line. For Docker Machine, use the Quickstart Terminal.

A Hello World container which just does one task and ends:

```
docker run hello-world
```

An interactive container which you connect to as if it's a remote machine:

```
docker run -it ubuntu
cat /etc/hosts
exit
```

Package the Pi Web App into a container image, and then running the app in a background container:

```
cd source
./package.sh
docker run -d -p 80:5000 sixeyed/pi-web-app
```

You can push the image to the Docker Hub, but not with the `sixeyed` tag - that's [my username](https://hub.docker.com/u/sixeyed/). If you want to try using the Hub, build the image with your own username in the tag, and then you can push it:

```
docker build -t my-hub-user/pi-web-app docker
docker push my-hub-user/pi-web-app
```


## Demo 3 - Docker swarm

Assuming you already have a Swarm. Connect and start the Pi web app running with two instances:

```
ssh docker@<manager-ip-address>
docker service create -p 80:5000 --name pi-web --replicas 2 sixeyed/pi-web-app
```

If you're using Docker for Azure then you can browse to the public IP address for your external load balancer, and see the app. You will get a reponse from any node, even if it isn't running the app, because Docker Swarm intelligently routes requests to nodes which can handle them.


## Demo 4 - Scaling the service

Whne you're running at higher scale, it's best to 'drain' the manager node, so it doesn't get used for application containers, and it only runs Swarm logic:

```
docker node update --availability drain _docker4azure-manager0
```

Then you can increase the scale of the Web app to 20 containers, and they will be distrbuted among the workers:

```
docker service scale pi-web=20
```

I used [Blitz](http://blitz.io) to run load tests, comparing performance of 2 and 20 instances.



## Demo 5 - Adding a Web Proxy

Increasing scale isn't the only way to improve performance - fronting web apps with a caching proxy can be a huge performance boost. 

[Nginx](http://nginx.org/) is a very lightweight and performant HTTP server, which has an [official image on the Docker Hub](https://hub.docker.com/_/nginx/). You can set it up as a reverse proxy, using [this configuration](proxy/nginx.conf). The key part of the config is that the Nginx server will route traffic to the host called `pi-web`. By running the app container and the proxy container in the same Docker network, they can refer to each other by name:

```
docker network create pi-web
docker run -d --name pi-web --network pi-web sixeyed/pi-web-app
docker run -d --name pi-proxy -p 80:80 --network pi-web sixeyed/pi-web-proxy
```

You don't need to publish port 5000 on the web app - the proxy can see it, because it's on the same network. When you browse to http://localshost (or http://[docker-machine ip]) your content gets served by Nginx.

You can check the logs for the app container:

```
docker logs -f pi-web
```

When you browse to a new page like http://localhost/pi?dp=1234 yoy'll see the logs from ASP.NET serving the response. Refresh your browser, and there are no new log entries - because the proxy has served the response from its cache, so the traffic doesn't go to ASP.NET.

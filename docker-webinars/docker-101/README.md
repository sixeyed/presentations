
## Demo 1 - Linux

```
docker version
```

```
docker container run -d nginx
```

Browse.

## Demo 1 - Windows

```
docker version
```

```
docker container run -d microsoft/iis:nanoserver
```

```
docker container inspect <id>
```

Browse.

## Demo 2 - Linux

Walk through [`vote` Dockerfile]().

```
docker image build -t sixeyed/vote:linux .
```

```
docker image push sixeyed/vote:linux
```

## Demo 2 - Windows

Walk through [.NET Core `worker` Dockerfile]().

```
docker image build -t sixeyed/worker:windows .
```

```
docker image push sixeyed/worker:windows
```

## Demo 3 - Linux

```
docker-compose -f docker-compose-simple.yml build
```

```
docker-compose -f docker-compose-simple.yml up -d
```

Browse to: 
- http://localhost:5000
- http://localhost:5001


## Demo 3 - Windows

```
docker-compose -f docker-compose-windows.yml build
```

```
docker-compose -f docker-compose-windows.yml up -d
```

Browse to: 
- http://localhost:5000
- http://localhost:5001


## Demo 4 - UCP

Deploy `vote-stack.yml`.

Browse to: 
- http://llb.sixeyed.com:5000
- http://llb.sixeyed.com:5001
## Demo 1 - app v1.2

Build from source:

```
cd C:\scm\github\sixeyed\docker-windows-workshop

docker image build --tag sixeyed/signup-web:1.2 --file part-2\web-1.2\Dockerfile .
```

Run:

```
cd app

docker-compose -f docker-compose-1.2.yml up -d 
```


## Demo 3 - app v1.3

> Update SignUp.aspx.cs to publish event. 

> Walk through message handler code.

Build:

```
cd C:\scm\github\sixeyed\docker-windows-workshop

docker image build --tag  sixeyed/signup-web:1.3 -f part-3\web-1.3\Dockerfile .

docker image build --tag sixeyed/signup-save-handler -f part-3\save-handler\Dockerfile .
```

Run with message queue:

```
cd app

docker-compose -f .\docker-compose-1.3.yml up -d
```

## Demo 3 - analytics

Build:

```
cd C:\scm\github\sixeyed\docker-windows-workshop

docker image build --tag sixeyed/signup-index-handler --file part-3\index-handler\Dockerfile .
```

Run with Elasticsearch & Kibana:

```
cd app

docker-compose -f .\docker-compose-1.4.yml up -d
```


## Demo 4 - CI / CD

Clean up:

```
docker container rm -f $(docker container ls -aq)
```

> Walk through `part-6` scripts

Build:

```
cd C:\scm\github\sixeyed\docker-windows-workshop\part-6

docker-compose`
 -f .\app\docker-compose.yml `
 -f .\app\docker-compose.build.yml `
 -f .\app\docker-compose.local.yml `
build
```
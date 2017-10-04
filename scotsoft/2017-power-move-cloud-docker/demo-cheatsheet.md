## Demo 1 - build with MSI & run

Build:

```
cd demo1

docker image build --tag scotsoft:v1 .
```

Deploy v1:

```
cd ..\app

docker-compose -f docker-compose-v1.yml up -d
```

## Demo - multi-stage Dockerfile

Build v2:

```
cd ..\..

docker image build --tag scotsoft:v2 --file demo2\Dockerfile .
```

Deploy v1:

```
cd app

docker-compose -f docker-compose-v2.yml up -d
``` 

Verify:

```
docker container exec app_signup-db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUpDb"
```

## Demo 3 - push to DTR, scanning & run in UCP

```
docker image tag scotsoft:v2 dtr.sixeyed.com/demo/scotsoft:v2

docker image push dtr.sixeyed.com/demo/scotsoft:v2
```

https://dtr.sixeyed.com

https://ucp.sixeyed.com
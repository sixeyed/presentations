
## v1

```
docker build -t sixeyed/sdd2017-web:v1 .\docker\web-v1

docker-compose -f .\app\docker-compose-v1.yml up -d
```

Browse to website, complete form manually, check SQL. 

## v1 tests

Build & run tests:

```
docker build -t sixeyed/sdd2017-e2e-tests -f docker\e2e-tests\Dockerfile .

docker run sixeyed/sdd2017-e2e-tests
```

Check SQL.

## v2

Build new web version & save handler, and run:

```
docker build -t sixeyed/sdd2017-web:v2 -f docker\web-v2\Dockerfile .

docker build -t sixeyed/sdd2017-save-handler -f docker\save-handler\Dockerfile .

docker-compose -f .\app\docker-compose-v2.yml up -d
```

Browse to website, complete form manually, check SQL. 

Run tests:

```
docker run sixeyed/sdd2017-e2e-tests
```

Check SQL, check handler logs.

## v3

Build index handler and run:

```
docker build -t sixeyed/sdd2017-index-handler -f docker\index-handler\Dockerfile .

docker-compose -f .\app\docker-compose-v3.yml up -d
```

Browse to Kibana, build dashboard.

## v4

Build homepage and run:

```
docker build -t sixeyed/sdd2017-homepage .\docker\homepage

docker-compose -f .\app\docker-compose-v4.yml up -d
```

## vNext

```
docker run -d -P --name cms sixeyed/umbraco-demo:i2d 
```
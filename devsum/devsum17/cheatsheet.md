# DevSum17

## Demo 1

Build v1:

```
cd C:\src\github\sixeyed\newsletter-signup\docker\web-v1

docker image build --tag sixeyed/signup-web:v1 .
```

Start v1:

```
cd C:\src\github\sixeyed\newsletter-signup\app

docker-compose -f docker-compose-v1.yml up -d
```

Run app & check SQL:

```
docker container exec app_db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

## Demo 2

Build v2:

```
cd C:\src\github\sixeyed\newsletter-signup

docker image build --tag sixeyed/signup-web -f docker\web\Dockerfile .

docker image build --tag sixeyed/signup-save-handler -f docker\save-handler\Dockerfile .
```

Start v2:

```
cd C:\src\github\sixeyed\newsletter-signup\app

docker-compose -f docker-compose-v2.yml up -d
```

## Demo 3

Build v3:

```
cd C:\src\github\sixeyed\newsletter-signup

docker image build --tag sixeyed/signup-index-handler -f docker\index-handler\Dockerfile .
```

Start v2:

```
cd C:\src\github\sixeyed\newsletter-signup\app

docker-compose -f docker-compose-v3.yml up -d
```

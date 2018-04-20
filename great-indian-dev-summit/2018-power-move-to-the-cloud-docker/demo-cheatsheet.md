## Setup

Clone the workshop repo:

```
git clone https://github.com/sixeyed/docker-windows-workshop.git

cd docker-windows-workshop
```

## Demo 1 - run local

> Walk through compose file

Deploy v1.1:

```
cd C:\scm\github\sixeyed\docker-windows-workshop\app

docker-compose -f docker-compose-1.1.yml up -d
``` 

Browse to app:

```
docker container inspect app_signup-web_1
```

Save form. Verify:

```
docker container exec app_signup-db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

Push to DTR:

```
docker image tag `
  sixeyed/signup-web:1.1 `
  dtr.sixeyed.com/newsletter/signup-web:1.1

docker login dtr.sixeyed.com --username elton

docker image push `
  dtr.sixeyed.com/newsletter/signup-web:1.1
```

> Fails - only CI server has push permission


## Demo 3 - scanning & run in UCP

> Walk through setup at https://dockr.ly/ee-azure

> Walk through generated resources

```
cd 'C:\Users\Elton Stoneman\Dropbox\Sessions\2018\devops-live\2018-docker-power-move-cloud\bundle'

. ./env.ps1
```

https://dtr.sixeyed.com

https://ucp.sixeyed.com
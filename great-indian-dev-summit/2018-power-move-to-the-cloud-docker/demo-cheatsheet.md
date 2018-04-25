## Setup

Launch:

- Docker for Windows
- PowerShell
- Sqlectron
- Firefox open at [Docker Hub](https://hub.docker.com/r/sixeyed/signup-web/), [UCP](https://ucp.sixeyed.com) and [DTR](https://dtr.sixeyed.com)
- VS Code with presentations
- VS Code with workshop

Turn off Defender; switch PowerShell to workshop dir:

```
Set-MpPreference -DisableRealtimeMonitoring $true

cd C:\scm\github\sixeyed\docker-windows-workshop\app
```

## Demo 1 - run local

> Walk through compose file

Deploy v1.4:

```
docker-compose `
  -f .\docker-compose-1.4.yml `
  up -d
``` 

Browse to app:

```
docker container inspect app_signup-web_1
```

Save form. Verify:

> Use Sqlectron or...

```
docker container exec app_signup-db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```

## Demo 2 - run in test

Push to DTR:

```
docker image tag `
  sixeyed/signup-web:1.3 `
  dtr.sixeyed.com/newsletter/signup-web:1.3

docker login dtr.sixeyed.com --username elton

docker image push `
  dtr.sixeyed.com/newsletter/signup-web:1.3
```

> Fails, only CI server has access - [dtr.sixeyed.com](https://dtr.sixeyed.com)

> Deploy to Windows Server in Azure

Browse at [gids18-test.southindia.cloudapp.azure.com](http://gids18-test.southindia.cloudapp.azure.com)

## Demo 3 - scanning & run in UCP

> Walk through generated Azure resources

```
cd 'C:\Users\Elton Stoneman\Dropbox\Sessions\2018\great-indian-dev-summit\02-docker-power-move-cloud\bundle'

. ./env.ps1
```

https://dtr.sixeyed.com

https://ucp.sixeyed.com

Deploy app and browse at [gids18-prod.southindia.cloudapp.azure.com](http://gids18-test.southindia.cloudapp.azure.com)
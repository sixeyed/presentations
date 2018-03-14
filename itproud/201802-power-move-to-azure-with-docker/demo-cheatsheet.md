## Setup

Clone the workshop repo:

```
git clone https://github.com/sixeyed/docker-windows-workshop.git

cd docker-windows-workshop
```

## Demo 1 - Simple Containers

Run IIS:

```
docker container run -d `
  microsoft/iis:nanoserver
```

Get IP address with `docker container inspect` & browse.

Build hostname web app:

```
cd C:\scm\github\sixeyed\docker-windows-workshop\part-1\hostname-app

docker image build --tag hostname-app .
```

Run multiple instances:

```
for ($i=0; $i -lt 5; $i++) {
    & docker container run --detach --name "app-$i" sixeyed/hostname-app
}
```

Browse to them all:

```
for ($i=0; $i -lt 5; $i++) {
    $ip = & docker container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' "app-$i"
    firefox "http://$ip"
}
```

Check compute:

```
Get-Process -Name w3wp | select Id, Name, WorkingSet, Cpu
```

## Demo 2 - build & ship

Build v1.1:

```
cd C:\scm\github\sixeyed\docker-windows-workshop\part-2\web-1.1

docker image build --tag sixeyed/signup-web:1.1 .
```

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
docker image tag sixeyed/signup-web:1.1 dtr.sixeyed.com/newsletter/signup-web:1.1

docker image push dtr.sixeyed.com/newsletter/signup-web:1.1
```

> Fails - only CI server has push permission


## Demo 3 - scanning & run in UCP

> Walk through setup at https://dockr.ly/ee-azure

> Walk through generated resources

https://dtr.sixeyed.com

https://ucp.sixeyed.com
## Demo 1 - I2D and run app locally

Install:

```
Install-Module Image2Docker

Import-Module Image2Docker
```

Run:

```
ConvertTo-Dockerfile `
 -ImagePath C:\VMs\win2003-iis.vhd `
 -OutputPath C:\winops `
 -Artifact IIS `
 -ArtifactParam SignUp.Web `
 -Verbose 
```

Build:

```
cd /winops

docker image build --tag signup-web:v1 .
```

Deploy V1:

```
docker container run --detach signup-web:v1 
```

Hmm. Check logs in `C:\websites\SignUp.Web\App_Data\SignUp.log`

### Part 2 - fix

Fix Web.config - connection string:

```
<add name="SignUpDbEntities" 
     connectionString="metadata=res://*/Model.SignUpModel.csdl|res://*/Model.SignUpModel.ssdl|res://*/Model.SignUpModel.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=signup-db;initial catalog=SignUpDb;user id=sa;password=DockerCon!!!;MultipleActiveResultSets=True;App=EntityFramework&quot;" 
     providerName="System.Data.EntityClient" />
```

Add to Dockerfile:

```
ENTRYPOINT ["powershell"]
CMD Start-Service W3SVC; `
    Invoke-WebRequest http://localhost:8090 -UseBasicParsing | Out-Null; `
    Get-Content -path 'C:\websites\SignUp.Web\App_Data\SignUp.log' -Tail 1 -Wait
```

Build v2:

```
docker image build --tag signup-web:v2 .
```

Run with database:

```

docker-compose up -d
```

Complete form. 

Verify:

```
docker container exec demo1_signup-db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUpDb"
```

## Demo 2 - push to DTR, scanning & run in cloud VM

```
docker image tag signup-web:v2 ` 
 dtr.sixeyed.com/winops/signup-web:v2

docker image push dtr.sixeyed.com/winops/signup-web:v2
```

https://dtr.sixeyed.com

Login to VM - show Compose:

```
docker-compose up -d
```


## Demo 3 - tour signup app on UCP

https://ucp.sixeyed.com
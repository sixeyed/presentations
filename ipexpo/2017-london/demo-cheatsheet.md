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
 -OutputPath C:\ipexpo `
 -Artifact IIS `
 -ArtifactParam SignUp.Web `
 -Verbose 
```

Build:

```
cd /ipexpo

docker image build --tag signup-web .
```

Deploy V1:

```
docker container run --detach --publish 8090 signup-web 
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

docker container run --detach --name signup-db signup-db

docker container run --detach --publish 8090 signup-web:v2
```

Complete form. 

Verify:

```
docker container exec signup-db powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUpDb"
```

## Demo 2 - push to DTR, scanning & run in UCP

```
docker image tag signup-web:v2 dtr.sixeyed.com/ipexpo/signup-web:v2

docker image push dtr.sixeyed.com/ipexpo/signup-web:v2
```

https://dtr.sixeyed.com

https://ucp.sixeyed.com
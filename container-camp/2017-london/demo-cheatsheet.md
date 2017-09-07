
## Part 1 - VMs

- Demo app in Windows Server 2003 VM
- Shut down VM
- Create Azure lab VM

Run Azure CLI in a container:

```
docker container run -it az 
```

```
az login
```

```
./create-lab-vm.ps1
```

## Part 2 - Image2Docker

Install:

```
Install-Module Image2Docker

Import-Module Image2Docker
```

Run:

```
ConvertTo-Dockerfile `
 -ImagePath C:\VMs\win2003-iis.vhd `
 -OutputPath C:\ccuk `
 -Artifact IIS -ArtifactParam SignUp.Web `
 -Verbose 
```

Build & ship:

```
cd c:\ccuk

docker image build -t sixeyed/signup-web:ccuk-1 .

docker image push sixeyed/signup-web:ccuk-1 
```

Deploy V1 - error!

```
docker container run -d -p 80:8090 sixeyed/signup-web:ccuk-1 
```

Check logs in `C:\websites\SignUp.Web\App_Data\SignUp.log`

## Part 3 - fix

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
docker image build -t sixeyed/signup-web:ccuk-2 .
```

Run with database:

```
docker container rm -f $(docker container ls -aq)
docker-compose up -d
```

## Part 4 - da da!

Complete form. 

Verify:

```
docker container exec app_signup-db_1 powershell `
 "Invoke-SqlCmd -Query 'SELECT * FROM Prospects' -Database SignUp"
```


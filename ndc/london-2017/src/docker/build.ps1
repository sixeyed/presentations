#$msBuildPath = "$env:windir\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$msBuildPath = "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"

# publish website:
& $msBuildPath ..\ProductLaunch\ProductLaunch.Web\ProductLaunch.Web.csproj /p:OutputPath=..\..\docker\web\ProductLaunchWeb  /p:DeployOnBuild=true

# publish message handlers:
& $msBuildPath ..\ProductLaunch\ProductLaunch.MessageHandlers.SaveProspect\ProductLaunch.MessageHandlers.SaveProspect.csproj /p:OutputPath=..\..\docker\save-prospect\SaveProspectHandler
& $msBuildPath ..\ProductLaunch\ProductLaunch.MessageHandlers.IndexProspect\ProductLaunch.MessageHandlers.IndexProspect.csproj /p:OutputPath=..\..\docker\index-prospect\IndexProspectHandler

# build images:
docker build -t sixeyed/product-launch-web:v4 .\web
docker build -t sixeyed/save-prospect-handler:v4 .\save-prospect
docker build -t sixeyed/index-prospect-handler:v4 .\index-prospect
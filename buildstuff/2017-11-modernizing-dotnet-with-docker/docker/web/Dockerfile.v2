# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-webdeploy AS builder

WORKDIR C:\src\SignUp.Web
COPY src\SignUp.Web\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild SignUp.Web.csproj /p:OutputPath=c:\out\web\SignUpWeb `
        /p:DeployOnBuild=true /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath

# app image
FROM microsoft/aspnet:4.6.2-windowsservercore-10.0.14393.1884
SHELL ["powershell"]

RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app' -Force; `
    New-WebApplication -Name 'ProductLaunch' -Site 'web-app' -PhysicalPath 'C:\web-app' -Force

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"

HEALTHCHECK --interval=5s `
 CMD powershell -command `
    try { `
     $response = iwr http://localhost/ProductLaunch -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]
COPY .\docker\web\bootstrap.ps1 C:\

COPY --from=builder C:\out\web\SignUpWeb\_PublishedWebsites\SignUp.Web C:\web-app
# escape=`

# build agent
FROM sixeyed/msbuild:4.5.2-webdeploy
COPY src\ProductLaunch C:\src
RUN C:\src\ProductLaunch.Web\build.ps1

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.693
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

RUN New-Item -Path 'C:\web-app' -Type Directory; `
    New-WebApplication -Name ProductLaunch -Site 'Default Web Site' -PhysicalPath 'C:\web-app'

HEALTHCHECK CMD powershell -command `
    try { `
     $response = iwr http://localhost/ProductLaunch -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]

ENV DB_CONNECTION_STRING="sqlserver"
ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"

COPY .\src\docker\bootstrap.ps1 C:\
COPY --from=0 C:\out\web\ProductLaunchWeb\_PublishedWebsites\ProductLaunch.Web C:\web-app
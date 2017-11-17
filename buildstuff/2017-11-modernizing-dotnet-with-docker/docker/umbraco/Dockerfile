# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV UMBRACO_VERSION="7.6.0" `
    UMBRACO_DOWNLOAD_ID="270489"

RUN Invoke-WebRequest -UseBasicParsing -OutFile umbraco.zip -Uri "https://our.umbraco.org/ReleaseDownload?id=$($env:UMBRACO_DOWNLOAD_ID)"; `
    Expand-Archive umbraco.zip -DestinationPath C:\umbraco

# app image
FROM microsoft/aspnet:4.6.2-windowsservercore-10.0.14393.1884
SHELL ["powershell"]

ENV UMBRACO_VERSION="7.6.0" `
    UMBRACO_ROOT="C:\inetpub\wwwroot\Umbraco"

RUN Remove-Website 'Default Web Site'; `
    New-Item -Path $env:UMBRACO_ROOT -Type Directory -Force; `
    New-Website -Name 'umbraco' -PhysicalPath $env:UMBRACO_ROOT -Port 80 -Force; 

HEALTHCHECK --interval=5s `
 CMD powershell -command `
    try { `
     $response = iwr http://localhost/ -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY .\docker\umbraco\Set-UmbracoAcl.ps1 C:\
COPY --from=installer C:\umbraco ${UMBRACO_ROOT}

RUN C:\Set-UmbracoAcl.ps1
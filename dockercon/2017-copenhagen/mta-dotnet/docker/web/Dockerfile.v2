# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-webdeploy AS builder

COPY src\ C:\src
WORKDIR C:\src\DockerSamples.AspNetChat.Web
RUN ["powershell", ".\\build.ps1"]

# app image
FROM microsoft/aspnet:windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR C:\web-app
RUN Remove-Website -Name 'Default Web Site';` 
    Set-ItemProperty IIS:\AppPools\DefaultAppPool -Name processModel.identityType -Value LocalSystem; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app' -ApplicationPool 'DefaultAppPool'

COPY --from=builder C:\out\_PublishedWebsites\DockerSamples.AspNetChat.Web C:\web-app

ENTRYPOINT ["powershell"]
CMD Remove-Item -Force C:\web-app\connection-strings.config; `
    New-Item -Path C:\web-app\connection-strings.config -ItemType SymbolicLink -Value C:\ProgramData\Docker\secrets\chat-connection-strings; `
    Start-Service W3SVC; `
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null; `
    Get-Content -path 'C:\web-app\App_Data\Chat.log' -Tail 1 -Wait
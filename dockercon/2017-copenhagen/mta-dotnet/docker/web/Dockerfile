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
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'

COPY --from=builder C:\out\_PublishedWebsites\DockerSamples.AspNetChat.Web C:\web-app
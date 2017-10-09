# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-webdeploy AS builder

WORKDIR C:\src\DockerSamples.AspNetChat.Web
COPY src\DockerSamples.AspNetChat.Web\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src\ C:\src
RUN msbuild DockerSamples.AspNetChat.Web.csproj /p:OutputPath=c:\out `
        /p:DeployOnBuild=true /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath

# app image
FROM microsoft/aspnet:windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR C:\web-app
RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app'

COPY --from=builder C:\out\_PublishedWebsites\DockerSamples.AspNetChat.Web C:\web-app
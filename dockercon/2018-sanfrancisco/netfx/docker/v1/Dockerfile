# escape=`
FROM microsoft/aspnet:3.5-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY WebFormsApp.zip .
RUN Expand-Archive -Path WebFormsApp.zip -DestinationPath C:\; `
    Remove-Item WebFormsApp.zip

RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\WebFormsApp' -ApplicationPool '.NET v2.0'

VOLUME C:\logs
COPY .\v1\startup.ps1 .
ENTRYPOINT ["powershell", ".\\startup.ps1"]

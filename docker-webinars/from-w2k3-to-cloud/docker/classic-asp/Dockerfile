# escape=`
FROM microsoft/iis:windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature Web-ASP

COPY ./share/ClassicAspApp.zip .

RUN Expand-Archive -Path ClassicAspApp.zip -DestinationPath C:\ClassicAspApp; `
    Remove-Item ClassicAspApp.zip

RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name web-app -Port 80 -PhysicalPath C:\ClassicAspApp
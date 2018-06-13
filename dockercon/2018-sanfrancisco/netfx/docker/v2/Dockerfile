# escape=`
FROM microsoft/aspnet:3.5-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY WebFormsApp.zip .
RUN Expand-Archive -Path WebFormsApp.zip -DestinationPath C:\; `
    Remove-Item WebFormsApp.zip
    
ENV APP_ROOT="C:\WebFormsApp" `
    LOG4NET_CONFIG_PATH="" `
    APPSETTINGS_CONFIG_PATH="" `
    CONNECTIONSTRINGS_CONFIG_PATH=""

RUN Import-Module WebAdministration; `
    Set-ItemProperty 'IIS:\AppPools\.NET v2.0' -Name processModel.identityType -Value LocalSystem; `
    Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath $env:APP_ROOT -ApplicationPool '.NET v2.0'

VOLUME C:\logs
COPY .\v2\startup.ps1 .
ENTRYPOINT ["powershell", ".\\startup.ps1"]
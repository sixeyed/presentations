# escape=`
FROM microsoft/aspnet:3.5-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY WebFormsApp.zip .
RUN Expand-Archive -Path WebFormsApp.zip -DestinationPath C:\; `
    Remove-Item WebFormsApp.zip
  
ENV APP_ROOT="C:\WebFormsApp" `
    LOG4NET_CONFIG_PATH="" `
    APPSETTINGS_CONFIG_PATH="" `
    CONNECTIONSTRINGS_CONFIG_PATH="" `
    DEPENDENCY_CHECK_ENABLED=""

RUN Import-Module WebAdministration; `
    Set-ItemProperty 'IIS:\AppPools\.NET v2.0' -Name processModel.identityType -Value LocalSystem; `
    Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'web-app' -Port 80 -PhysicalPath $env:APP_ROOT -ApplicationPool '.NET v2.0'

VOLUME C:\logs

COPY .\v4\startup.ps1 .
ENTRYPOINT ["powershell", ".\\startup.ps1"]

COPY DependencyChecker.zip .
RUN Expand-Archive -Path DependencyChecker.zip -DestinationPath $env:APP_ROOT; `
    Remove-Item DependencyChecker.zip

COPY HealthChecker.zip .
RUN Expand-Archive -Path HealthChecker.zip -DestinationPath $env:APP_ROOT; `
    Remove-Item HealthChecker.zip; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH + ';' + $env:APP_ROOT, [EnvironmentVariableTarget]::Machine)

HEALTHCHECK --interval=2s `
  CMD ["HealthChecker.exe"]
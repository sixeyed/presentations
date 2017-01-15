# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord
RUN Add-WindowsFeature Web-server
    
COPY index.html c:/inetpub/wwwroot/index.html

EXPOSE 80

COPY ServiceMonitor.exe /
CMD ["C:\\ServiceMonitor.exe", "w3svc"]
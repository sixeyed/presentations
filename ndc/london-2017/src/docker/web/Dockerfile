# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord
RUN Add-WindowsFeature Web-server, NET-Framework-45-ASPNET, Web-Asp-Net45; `
    Remove-Website -Name 'Default Web Site'
    
COPY ProductLaunchWeb/_PublishedWebsites/ProductLaunch.Web /product-launch-web
RUN New-Website -Name 'product-launch' -PhysicalPath 'C:\product-launch-web' -Port 80 -Force

EXPOSE 80
ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"

COPY ServiceMonitor.exe /
COPY bootstrap.ps1 /
ENTRYPOINT ./bootstrap.ps1
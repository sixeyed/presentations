# escape=`
FROM microsoft/aspnet:windowsservercore-10.0.14393.693
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord
ENV DB_CONNECTION_STRING="sqlserver"

ENTRYPOINT ["powershell", "./bootstrap.ps1"]
COPY bootstrap.ps1 /

COPY ProductLaunch-1.0.msi /
RUN Start-Process msiexec.exe -ArgumentList '/i', 'C:\ProductLaunch-1.0.msi', '/quiet', '/norestart' -NoNewWindow -Wait
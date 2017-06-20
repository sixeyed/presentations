# escape=`
FROM microsoft/aspnet:windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENTRYPOINT ["powershell", "./bootstrap.ps1"]
COPY bootstrap.ps1 /

COPY SignUp-1.0.msi /
RUN Start-Process msiexec.exe -ArgumentList '/i', 'C:\SignUp-1.0.msi', '/quiet', '/norestart' -NoNewWindow -Wait
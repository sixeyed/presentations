# escape=`

# builder
FROM sixeyed/msbuild:4.5.2 AS builder
COPY src\ProductLaunch C:\src
RUN C:\src\ProductLaunch.MessageHandlers.SaveProspect\build.ps1

# app image
FROM microsoft/windowsservercore:10.0.14393.1066
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

WORKDIR /save-prospect-handler
CMD .\ProductLaunch.MessageHandlers.SaveProspect.exe

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"

COPY --from=builder C:\out\save-prospect\SaveProspectHandler .
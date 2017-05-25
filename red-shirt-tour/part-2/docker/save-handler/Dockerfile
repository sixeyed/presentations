# escape=`

FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1198 AS builder

WORKDIR C:\src\SignUp.MessageHandlers.SaveProspect
COPY src\SignUp\SignUp.MessageHandlers.SaveProspect\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src\SignUp C:\src
RUN msbuild SignUp.MessageHandlers.SaveProspect.csproj /p:OutputPath=c:\out\save-prospect\SaveProspectHandler

# app image
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

WORKDIR /save-prospect-handler
CMD .\SignUp.MessageHandlers.SaveProspect.exe

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222" `
    DB_MAX_RETRY_COUNT="5" `
    DB_MAX_DELAY_SECONDS="10"

COPY --from=builder C:\out\save-prospect\SaveProspectHandler .
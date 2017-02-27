# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

WORKDIR /index-prospect-handler
COPY IndexProspectHandler .

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222" `
    ELASTICSEARCH_URL="http://elasticsearch:9200"

CMD .\ProductLaunch.MessageHandlers.IndexProspect.exe
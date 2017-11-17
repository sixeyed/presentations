# escape=`
FROM sixeyed/msbuild:netfx-4.5.2 AS builder

WORKDIR C:\src\SignUp.MessageHandlers.IndexProspect
COPY src\SignUp.MessageHandlers.IndexProspect\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild SignUp.MessageHandlers.IndexProspect.csproj /p:OutputPath=c:\out\index-handler

# app image
FROM microsoft/windowsservercore:10.0.14393.1884

WORKDIR C:\index-handler
CMD .\SignUp.MessageHandlers.IndexProspect.exe

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222" `
    ELASTICSEARCH_URL="http://elasticsearch:9200"

COPY --from=builder C:\out\index-handler .
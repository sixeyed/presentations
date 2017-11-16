# escape=`
FROM sixeyed/msbuild:netfx-4.5.2 AS builder

WORKDIR C:\src\SignUp.MessageHandlers.SaveProspect
COPY src\SignUp.MessageHandlers.SaveProspect\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src C:\src
RUN msbuild SignUp.MessageHandlers.SaveProspect.csproj /p:OutputPath=c:\out\save-handler

# app image
FROM microsoft/windowsservercore:10.0.14393.1884

WORKDIR C:\save-handler
CMD .\SignUp.MessageHandlers.SaveProspect.exe

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"`
    DB_CONNECTION_STRING_PATH="C:\ProgramData\Docker\secrets\signup-db.connectionstring"

COPY --from=builder C:\out\save-handler .
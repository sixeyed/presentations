# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-ssdt AS builder

COPY src\ C:\src
WORKDIR C:\src\DockerSamples.AspNetChat.Database
RUN ["powershell", ".\\build.ps1"]

# db image
FROM microsoft/mssql-server-windows-express
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

VOLUME C:\database
ENV ACCEPT_EULA="Y" `
    PASSWORD_PATH="C:\ProgramData\Docker\secrets\audit-db.password"

WORKDIR C:\init
COPY docker/audit-db/Initialize-Database.ps1 .
CMD ./Initialize-Database.ps1 -sa_password $env:sa_password -Verbose

COPY --from=builder C:\src\bin\Debug\DockerSamples.AspNetChat.Database.dacpac .
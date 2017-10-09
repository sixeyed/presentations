# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-ssdt AS builder

WORKDIR C:\src
COPY src\DockerSamples.AspNetChat.Database\ .
RUN msbuild DockerSamples.AspNetChat.Database.sqlproj `
      /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40" `
      /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40"

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
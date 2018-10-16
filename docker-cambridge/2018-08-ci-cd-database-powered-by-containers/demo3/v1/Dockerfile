# escape=`
FROM dockersamples/assets-db-builder AS builder

WORKDIR C:\src
COPY src .
RUN msbuild Assets.Database.sqlproj `
    /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61804.210\lib\net46" `
    /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61804.210\lib\net46"

# db image
FROM microsoft/mssql-server-windows-express:2016-sp1
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV ACCEPT_EULA="Y" `
    DATA_PATH="C:\data" `
    sa_password="D0cker!a8s"

VOLUME ${DATA_PATH}

WORKDIR C:\init
COPY Initialize-Database.ps1 .
ENTRYPOINT ["powershell", "./Initialize-Database.ps1"]

COPY --from=builder ["C:\\Program Files\\Microsoft SQL Server\\140\\DAC", "C:\\Program Files\\Microsoft SQL Server\\140\\DAC"]
COPY --from=builder C:\src\bin\Debug\Assets.Database.dacpac .
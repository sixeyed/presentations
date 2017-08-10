# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-ssdt AS builder

WORKDIR C:\src\NerdDinner.Database
COPY src\NerdDinner.Database .
RUN msbuild NerdDinner.Database.sqlproj `
    /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40" `
    /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61026\lib\net40"

# db image
FROM microsoft/mssql-server-windows-express

ENV ACCEPT_EULA="Y" `
    DATA_PATH="C:\data" `
    sa_password="DockerCon!!!"

VOLUME ${DATA_PATH}
WORKDIR C:\init

COPY Initialize-Database.ps1 .
CMD powershell ./Initialize-Database.ps1 -sa_password $env:sa_password -data_path $env:data_path -Verbose

COPY --from=builder C:\src\NerdDinner.Database\bin\Debug\NerdDinner.Database.dacpac .
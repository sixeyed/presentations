# escape=`
FROM microsoft/mssql-server-windows-express:2016-sp1-windowsservercore-10.0.14393.1715

ENV ACCEPT_EULA="Y" `
    PASSWORD_PATH="C:\ProgramData\Docker\secrets\signup-db-sa.password"

CMD ["powershell", "./init.ps1", "-Verbose"]

COPY ./docker/db/init.ps1 .
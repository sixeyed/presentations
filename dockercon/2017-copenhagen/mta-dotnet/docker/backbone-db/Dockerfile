# escape=`
FROM microsoft/mssql-server-windows-express

ENV ACCEPT_EULA="Y" `
    PASSWORD_PATH="C:\ProgramData\Docker\secrets\backbone-db.password"

COPY docker/backbone-db/Init.ps1 .

CMD ["powershell", "./Init.ps1", "-Verbose"]
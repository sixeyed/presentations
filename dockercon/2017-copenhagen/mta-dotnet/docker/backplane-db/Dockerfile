# escape=`
FROM microsoft/mssql-server-windows-express

ENV ACCEPT_EULA="Y" `
    PASSWORD_PATH="C:\ProgramData\Docker\secrets\backplane-db.password"

COPY docker/backplane-db/Init.ps1 .

CMD ["powershell", "./Init.ps1", "-Verbose"]
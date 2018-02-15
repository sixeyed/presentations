# escape=`
FROM microsoft/mssql-server-windows-express:2016-sp1
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ACCEPT_EULA="Y" `
    sa_password="DockerCon!!!" `
    DATA_PATH="C:\mssql"

VOLUME ${DATA_PATH}

WORKDIR C:\init
COPY . .

CMD ./init.ps1 -sa_password $env:sa_password -Verbose

HEALTHCHECK CMD powershell -command `
    try { `
     $result = Invoke-SqlCmd -Query 'SELECT TOP 1 1 FROM Countries' -Database SignUpDb; `
     if ($result[0] -eq 1) { return 0} `
     else {return 1}; `
} catch { return 1 }
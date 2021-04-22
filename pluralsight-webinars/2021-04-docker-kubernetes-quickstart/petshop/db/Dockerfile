# escape=`
FROM dak4dotnet/sql-server:2017

ENV sa_password="DockerCon!!!"

COPY ./database/DatabaseScripts/ .
RUN ["powershell", "./InstallDatabases.ps1"]
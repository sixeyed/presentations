#escape = `
FROM microsoft/iis
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Add-Content c:\inetpub\wwwroot\index.html '<h1>Hello Docker London</h1>'
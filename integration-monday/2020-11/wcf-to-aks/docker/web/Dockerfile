# escape=`
FROM mcr.microsoft.com/dotnet/framework/aspnet:3.5
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature NET-HTTP-Activation; `
    Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'petshop-web' -Port 80 -PhysicalPath 'C:\petshop-web\' -Force

COPY ./zips/petshop-web.zip .
RUN Expand-Archive -Path petshop-web.zip -DestinationPath C:\
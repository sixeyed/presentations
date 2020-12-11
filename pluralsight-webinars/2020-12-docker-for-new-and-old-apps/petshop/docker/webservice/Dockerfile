# escape=`
FROM mcr.microsoft.com/dotnet/framework/aspnet:3.5
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature NET-HTTP-Activation; `
    Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'petshop-webservice' -Port 80 -PhysicalPath 'C:\petshop-webservice\' -Force

COPY ./zips/petshop-webservice.zip .
RUN Expand-Archive -Path petshop-webservice.zip -DestinationPath C:\
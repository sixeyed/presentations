# escape=`
FROM microsoft/iis:nanoserver-sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY ./share/StaticHtml.zip .

RUN Expand-Archive -Path StaticHtml.zip -DestinationPath C:\StaticHtmlApp; `
    Remove-Item StaticHtml.zip

RUN Import-Module IISAdministration; `
    Remove-IISSite -Name 'Default Web Site' -Confirm:$false; `
    New-IISSite -Name web-app -BindingInformation "*:80:" -PhysicalPath C:\StaticHtmlApp
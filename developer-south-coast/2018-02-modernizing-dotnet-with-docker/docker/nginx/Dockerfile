# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NGINX_VERSION 1.12.2

RUN Invoke-WebRequest -UseBasicParsing -OutFile nginx.zip -Uri "http://nginx.org/download/nginx-$($env:NGINX_VERSION).zip"; `
    Expand-Archive nginx.zip -DestinationPath C:\; `
    Rename-Item "C:\nginx-$($env:NGINX_VERSION)" C:\nginx

# Nginx
FROM microsoft/windowsservercore:10.0.14393.1884

EXPOSE 80 443
WORKDIR C:\nginx
CMD ".\nginx"

COPY --from=installer C:\nginx\ .
COPY .\docker\nginx\conf .\conf
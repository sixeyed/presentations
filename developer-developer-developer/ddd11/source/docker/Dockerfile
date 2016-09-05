FROM microsoft/dotnet:core
MAINTAINER Elton Stoneman <elton@sixeyed.com>

COPY dotnetapp /dotnetapp

EXPOSE 5000

WORKDIR /dotnetapp

CMD ["dotnet", "PiWebApp.dll", "--server.urls", "http://0.0.0.0:5000"]
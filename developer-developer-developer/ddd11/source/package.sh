
dotnet publish -o docker/dotnetapp dotnet/PiWebApp

docker build -t sixeyed/pi-web-app
# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NATS_VERSION="v0.9.6"

# Download and expand released version
RUN Invoke-WebRequest -OutFile gnatsd.zip "https://github.com/nats-io/gnatsd/releases/download/$($env:NATS_VERSION)/gnatsd-$($env:NATS_VERSION)-windows-amd64.zip" -UseBasicParsing ; `
    Expand-Archive gnatsd.zip -DestinationPath C:\ ; `
    Move-Item "C:/gnatsd-$($env:NATS_VERSION)-windows-amd64" 'c:/gnatsd'; `
    Remove-Item gnatsd.zip

WORKDIR c:/gnatsd
COPY gnatsd.conf gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]
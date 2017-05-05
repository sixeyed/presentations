# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Get 64-bit Node - Kibana ships with an x86 version that doesn't work in Nano
ENV NODE_VERSION="6.9.4" `
    NODE_SHA256="d546418b58ee6e9fefe3a2cf17cd735ef0c7ddb51605aaed8807d0833beccbf6"

WORKDIR c:/node
RUN Invoke-WebRequest -OutFile node.exe "https://nodejs.org/dist/v$($env:NODE_VERSION)/win-x64/node.exe" -UseBasicParsing; `
    if ((Get-FileHash node.exe -Algorithm sha256).Hash -ne $env:NODE_SHA256) {exit 1} ;

# Kibana
ENV KIBANA_VERSION="5.1.1" `
    KIBANA_SHA1="a1c25cb36590e6bd3bb20932c402e150afacf8c8"

RUN Invoke-WebRequest -OutFile kibana.zip "https://artifacts.elastic.co/downloads/kibana/kibana-$($env:KIBANA_VERSION)-windows-x86.zip" -UseBasicParsing; `
    if ((Get-FileHash kibana.zip -Algorithm sha1).Hash -ne $env:KIBANA_SHA1) {exit 1} ; `
    Expand-Archive kibana.zip -DestinationPath C:\ ; `
    Move-Item c:\kibana-$($env:KIBANA_VERSION)-windows-x86 'c:\kibana'; `
    Remove-Item kibana.zip

# Default configuration for host & Elasticsearch URL
WORKDIR c:/kibana
RUN (Get-Content ./config/kibana.yml) -replace '#server.host: \"localhost\"', 'server.host: \"0.0.0.0\"' | Set-Content ./config/kibana.yml; `
    (Get-Content ./config/kibana.yml) -replace '#elasticsearch.url: \"http://localhost:9200\"', 'elasticsearch.url: \"http://elasticsearch:9200\"' | Set-Content ./config/kibana.yml

# REMARKS - DNS tweaks needed for Windows
RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord    

EXPOSE 5601
COPY docker-entrypoint.ps1 /
ENTRYPOINT ["powershell"]
CMD ["/docker-entrypoint.ps1"]
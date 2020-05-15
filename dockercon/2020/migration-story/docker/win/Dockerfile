FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019

ENTRYPOINT ["/app/Pi.Runtime.NetFx"]
CMD ["-m", "console", "-dp", "6"]

WORKDIR /app
COPY --from=sixeyed/pi:netfx-2002 /app/ .
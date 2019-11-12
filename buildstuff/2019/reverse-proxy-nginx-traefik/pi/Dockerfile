FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100 AS builder

WORKDIR /src
COPY src/Pi.Web.csproj .
RUN dotnet restore

COPY src/ .
RUN dotnet publish -c Release -o /out Pi.Web.csproj

# app image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

EXPOSE 80
ENTRYPOINT ["dotnet", "Pi.Web.dll"]

WORKDIR /app
COPY --from=builder /out/ .
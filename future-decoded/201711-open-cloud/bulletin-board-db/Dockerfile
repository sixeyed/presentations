FROM microsoft/mssql-server-linux:2017-CU1

ENV ACCEPT_EULA=Y \
    MSSQL_SA_PASSWORD=DockerCon!!!

WORKDIR /init
COPY init-db.* ./

RUN /opt/mssql/bin/sqlservr & ./init-db.sh
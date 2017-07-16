FROM microsoft/mssql-server-linux:ctp2-1

ENV ACCEPT_EULA=Y \
    SA_PASSWORD=R3pl4ceW!thS*cr*t \
    PASSWORD_PATH=/run/secrets/signup-db-sa.password

COPY startup.sh /
RUN chmod +x /startup.sh

CMD /startup.sh
    
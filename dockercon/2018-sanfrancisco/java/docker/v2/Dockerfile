FROM tomcat:7-jre8-alpine

COPY JavaWebApp.zip /
RUN rm -r -f /usr/local/tomcat/webapps && \
    mkdir -p /usr/local/tomcat/webapps/ROOT && \
    unzip /JavaWebApp.zip -d /usr/local/tomcat/webapps/ROOT && \
    rm /JavaWebApp.zip

ENV CATALINA_OPTS="-Dsecurerandom.source\=file:/dev/urandom" \
    APP_ROOT="/usr/local/tomcat/webapps/ROOT" \
    LOGGING_PROPERTIES_PATH="" \
    WEB_XML_PATH=""

COPY ./v2/startup.sh /
CMD ["/startup.sh"]
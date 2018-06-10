FROM tomcat:7

COPY JavaWebApp.zip /
RUN rm -r -f /usr/local/tomcat/webapps/ROOT && \
    unzip /JavaWebApp.zip -d /usr/local/tomcat/webapps/ROOT && \
    rm /JavaWebApp.zip

ENV APP_ROOT="/usr/local/tomcat/webapps/ROOT" \
    LOGGING_PROPERTIES_PATH="" \
    WEB_XML_PATH=""

COPY context.xml ${APP_ROOT}/META-INF/context.xml
COPY ./v2/startup.sh /
CMD ["/startup.sh"]
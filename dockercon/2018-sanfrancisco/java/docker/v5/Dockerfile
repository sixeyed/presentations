FROM ubuntu AS exporter

WORKDIR /exporter
#TODO - download JARs and WAR from Maven for nlighten/tomcat_exporter

#app image
FROM tomcat:7

COPY JavaWebApp.zip /
RUN rm -r -f /usr/local/tomcat/webapps/ROOT && \
    unzip /JavaWebApp.zip -d /usr/local/tomcat/webapps/ROOT && \
    rm /JavaWebApp.zip

ENV APP_ROOT="/usr/local/tomcat/webapps/ROOT" \
    LOGGING_PROPERTIES_PATH="" \
    WEB_XML_PATH="" \
    CONTEXT_XML_PATH="" \
    DEPENDENCY_CHECK_ENABLED="" \
    UTIL_ROOT="/usr/local/utils" \
    EXPORTER_ROOT="/usr/local/tomcat/webapps/metrics"

COPY ./v5/startup.sh /
CMD ["/startup.sh"]

#COPY DependencyChecker.jar ${UTIL_ROOT}

#COPY HealthChecker.jar ${UTIL_ROOT}
#HEALTHCHECK --interval=2s `
# CMD java $UTIL_ROOT/HealthChecker.jar

COPY --from=exporter /metrics/*.jar ??
COPY --from=exporter /metrics/xyz/war ${EXPORTER_ROOT}

#TODO - configure custom port for metrics?
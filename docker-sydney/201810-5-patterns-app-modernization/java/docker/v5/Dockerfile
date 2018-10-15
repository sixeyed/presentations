FROM alpine AS exporter

WORKDIR /exporter

ADD https://search.maven.org/remotecontent?filepath=io/prometheus/simpleclient/0.4.0/simpleclient-0.4.0.jar simpleclient-0.4.0.jar

ADD https://search.maven.org/remotecontent?filepath=io/prometheus/simpleclient_common/0.4.0/simpleclient_common-0.4.0.jar simpleclient_common-0.4.0.jar

ADD https://search.maven.org/remotecontent?filepath=io/prometheus/simpleclient_servlet/0.4.0/simpleclient_servlet-0.4.0.jar simpleclient_servlet-0.4.0.jar

ADD https://search.maven.org/remotecontent?filepath=io/prometheus/simpleclient_hotspot/0.4.0/simpleclient_hotspot-0.4.0.jar simpleclient_hotspot-0.4.0.jar

ADD https://search.maven.org/remotecontent?filepath=nl/nlighten/tomcat_exporter_client/0.0.6/tomcat_exporter_client-0.0.6.jar tomcat_exporter_client-0.0.6.jar

ADD https://search.maven.org/remotecontent?filepath=nl/nlighten/tomcat_exporter_servlet/0.0.6/tomcat_exporter_servlet-0.0.6.war tomcat_exporter_servlet-0.0.6.war

#app image
FROM tomcat:7-jre8-alpine

COPY JavaWebApp.zip /
RUN rm -r -f /usr/local/tomcat/webapps && \
    mkdir -p /usr/local/tomcat/webapps/ROOT && \
    unzip /JavaWebApp.zip -d /usr/local/tomcat/webapps/ROOT && \
    rm /JavaWebApp.zip

ENV CATALINA_OPTS="-Dsecurerandom.source\=file:/dev/urandom" \
    APP_ROOT="/usr/local/tomcat/webapps/ROOT" \
    LOGGING_PROPERTIES_PATH="" \
    WEB_XML_PATH="" \
    CONTEXT_XML_PATH="" \
    DEPENDENCY_CHECK_ENABLED="" \
    UTIL_ROOT="/usr/local/utils" \
    EXPORTER_ROOT="/usr/local/tomcat/webapps"

COPY ./v5/startup.sh /
CMD ["/startup.sh"]

COPY DependencyChecker.jar ${UTIL_ROOT}/DependencyChecker.jar

COPY HealthChecker.jar ${UTIL_ROOT}/HealthChecker.jar
HEALTHCHECK --interval=2s \
 CMD ["java", "-jar", "$UTIL_ROOT/HealthChecker.jar"]

COPY --from=exporter /exporter/*.jar ${CATALINA_HOME}/lib/
COPY --from=exporter /exporter/tomcat_exporter_servlet-0.0.6.war ${EXPORTER_ROOT}/metrics.war
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
    UTIL_ROOT="/usr/local/utils"

COPY ./v3/startup.sh /
CMD ["/startup.sh"]

#COPY DependencyChecker.jar ${UTIL_ROOT}
FROM tomcat:7

COPY JavaWebApp.zip /
RUN rm -r -f /usr/local/tomcat/webapps/ROOT && \
    unzip /JavaWebApp.zip -d /usr/local/tomcat/webapps/ROOT && \
    rm /JavaWebApp.zip
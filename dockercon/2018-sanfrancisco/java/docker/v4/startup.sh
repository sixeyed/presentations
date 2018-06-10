#!/bin/bash

function redirect_config_file () {
    if [ "$#" -eq 2 ] && [ -n $1 ] && [ -e $1 ]
    then
        ln -s -f $1 $2
        echo "STARTUP: Redirected $2 config to read from $1"
    fi
}

redirect_config_file \
  $LOGGING_PROPERTIES_PATH \
  $APP_ROOT/WEB-INF/classes/logging.properties

redirect_config_file \
  $WEB_XML_PATH \
  $APP_ROOT/WEB-INF/web.xml

redirect_config_file \
  $CONTEXT_XML_PATH \
  $APP_ROOT/META-INF/context.xml

if [ "$DEPENDENCY_CHECK_ENABLED" -eq "1" ] 
then
    echo STARTUP: Validating dependencies
    #TODO
    #java DependencyChecker.jar
fi

echo STARTUP: Starting Tomcat
catalina.sh run
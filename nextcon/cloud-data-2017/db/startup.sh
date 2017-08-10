#!/bin/bash

if [ -e $PASSWORD_PATH ] 
then 
  echo "Setting password from secret file: $PASSWORD_PATH"
  export SQLSERVR_SA_PASSWORD=$(< $PASSWORD_PATH)
  /opt/mssql/bin/sqlservr --reset-sa-password
else
  echo "Secret file not found: $PASSWORD_PATH. *** USING DEFAULT PASSWORD ***"
  /opt/mssql/bin/sqlservr
fi
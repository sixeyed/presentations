#!/bin/bash

docker service rm db

docker service create \
 --detach \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == linux' \
 --constraint 'node.labels.ram == l' \
 --env ACCEPT_EULA=Y \
 --env-file db-credentials.env \
 --publish mode=host,target=1433,published=1433 \
 --name db \
microsoft/mssql-server-linux:ctp2-1

docker service update --force web
 

#!/bin/bash

docker network create -d overlay newsletter

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == windows' \
 --env ACCEPT_EULA=Y \
 --env-file db-credentials.env \
 --name db \
 microsoft/mssql-server-windows-express

docker service create \
 --detach \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == windows' \
 --name elasticsearch \
 sixeyed/elasticsearch:nanoserver

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == windows' \
 --name message-queue \
 nats:nanoserver

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --publish mode=host,target=80,published=80 \
 --constraint 'node.platform.os == windows' \
 --env-file db-credentials.env \
 --name web \
 dockersamples/signup-web

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == windows' \
 --env-file db-credentials.env \
 --name save-handler \
 dockersamples/signup-save-handler

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == windows' \
 --name index-handler \
 dockersamples/signup-index-handler

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --publish mode=host,target=5601,published=5601 \
 --constraint 'node.platform.os == windows' \
 --name kibana \
 sixeyed/kibana:nanoserver
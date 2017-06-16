#!/bin/bash

docker service rm kibana

docker service rm elasticsearch

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == linux' \
 --name elasticsearch \
 elasticsearch:5.2

docker service create \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == linux' \
 --publish mode=host,target=5601,published=5601 \
 --name kibana \
 kibana:5.2

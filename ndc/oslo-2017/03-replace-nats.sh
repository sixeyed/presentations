#!/bin/bash

docker service rm message-queue

docker service create \
 --detach \
 --network newsletter --endpoint-mode dnsrr \
 --constraint 'node.platform.os == linux' \
 --name message-queue \
 nats:0.9.6

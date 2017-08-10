docker network create -d overlay newsletter

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --constraint 'node.platform.os == windows' `
 --secret signup-db-sa.password `
 --name db `
 dockersamples/signup-db

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --constraint 'node.platform.os == windows' `
 --name elasticsearch `
 sixeyed/elasticsearch:5.2.0-nanoserver

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --constraint 'node.platform.os == windows' `
 --name message-queue `
 nats:0.9.6-nanoserver

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --publish mode=host,target=80,published=80 `
 --constraint 'node.platform.os == windows' `
 --secret signup-db.connectionstring `
 --name web `
 dockersamples/signup-web

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --constraint 'node.platform.os == windows' `
 --secret signup-db.connectionstring `
 --name save-handler `
 dockersamples/signup-save-handler

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --constraint 'node.platform.os == windows' `
 --name index-handler `
 dockersamples/signup-index-handler

docker service create --detach `
 --network newsletter --endpoint-mode dnsrr `
 --publish mode=host,target=5601,published=5601 `
 --constraint 'node.platform.os == windows' `
 --name kibana `
 sixeyed/kibana:5.2.0-windowsservercore
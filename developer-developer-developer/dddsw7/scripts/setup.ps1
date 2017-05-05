
$ip = '127.0.0.1'

docker swarm init --listen-addr $ip --advertise-addr $ip

docker network create --driver overlay mta

docker service create `
 --network mta --endpoint-mode dnsrr `
 --env ACCEPT_EULA=Y --env-file db-credentials.env `
 --name mta-db `
 microsoft/mssql-server-windows-express
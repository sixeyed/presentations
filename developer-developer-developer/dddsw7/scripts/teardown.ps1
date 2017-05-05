
docker service rm $(docker service ls -q)

docker swarm leave -f
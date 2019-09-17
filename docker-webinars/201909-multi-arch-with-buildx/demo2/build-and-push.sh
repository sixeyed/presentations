build() {
  ip=$1
  os=$2
  arch=$3
  
  docker \
   --host tcp://$ip:2376 --tlsverify --tlscacert $ca --tlscert $cert --tlskey $key \
   image build --pull -t $JOB_NAME:$os-$arch .
}

push() {
  ip=$1
  os=$2
  arch=$3
    
  docker \
   --host tcp://$ip:2376 --tlsverify --tlscacert $ca --tlscert $cert --tlskey $key \
   login -u $hub_user -p $hub_password
   
  docker \
   --host tcp://$ip:2376 --tlsverify --tlscacert $ca --tlscert $cert --tlskey $key \
   image push $JOB_NAME:$os-$arch
}

cd ./ch04/exercises/image-gallery

armIp=$(nslookup linux.arm.workers.swarm.sixeyed | tail -n1 | grep Address | awk '{printf ($3" ")}' | tr -d ' ')
arm64Ip=$(nslookup linux.arm64.workers.swarm.sixeyed | tail -n1 | grep Address | awk '{printf ($3" ")}' | tr -d ' ')
amd64Ip=$(nslookup linux.amd64.workers.swarm.sixeyed | tail -n1 | grep Address | awk '{printf ($3" ")}' | tr -d ' ')
winIp=$(nslookup windows.amd64.workers.swarm.sixeyed | tail -n1 | grep Address | awk '{printf ($3" ")}' | tr -d ' ')

build $armIp 'linux' 'arm'
build $arm64Ip 'linux' 'arm64'
build $amd64Ip 'linux' 'amd64'
build $winIp 'windows' 'amd64'

push $armIp 'linux' 'arm'
push $arm64Ip 'linux' 'arm64'
push $amd64Ip 'linux' 'amd64'
push $winIp 'windows' 'amd64'
rm -r -f /root/.docker/manifests/docker.io_diamol_$JOB_BASE_NAME-latest

docker manifest create $JOB_NAME \
 $JOB_NAME:windows-amd64 $JOB_NAME:linux-amd64 $JOB_NAME:linux-arm64 $JOB_NAME:linux-arm
 
docker manifest inspect $JOB_NAME

docker login -u $hub_user -p $hub_password

docker manifest push $JOB_NAME

echo "https://cloud.docker.com/u/diamol/repository/registry-1.docker.io/diamol/$JOB_BASE_NAME/tags"
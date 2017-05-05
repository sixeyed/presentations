
docker build -t sixeyed/dddsw7-web:v1 .\docker\web-v1

docker service create `
 --network mta `
 --env-file db-credentials.env `
 --publish mode=host,target=80,published=80 `
 --name mta-app `
 sixeyed/dddsw7-web:v1
### v1 - with logging

Nothing to do here, the base Tomcat image runs the app server in the foreground, so we get console logging for free.

### v2 - add config

Reads config from Docker, using environment variables for paths:

```
docker image build -t sixeyed/dcsf-java:v2 -f ./v2/Dockerfile .
```

Run in swarm mode:

```
docker config create java-logging ./configs/logging.properties

docker config create java-web ./configs/web.xml

docker stack deploy -c ./docker-stack-v2.yml java
```

(or outside of swarm mode)

```
docker container run -d -P \
  -v $(pwd)/logging.properties:/logging.properties \
  -e LOGGING_PROPERTIES_PATH=/logging.properties \
  sixeyed/dcsf-java:v2

docker container run -d -P \
  -v $(pwd)/web.xml:/web.xml \
  -e WEB_XML_PATH=/web.xml \
  sixeyed/dcsf-java:v2

docker container run -d -P \
  -v $(pwd)/logging.properties:/logging.properties \
  -e LOGGING_PROPERTIES_PATH=/logging.properties \
  -v $(pwd)/web.xml:/web.xml \
  -e WEB_XML_PATH=/web.xml \
  sixeyed/dcsf-java:v2
```

## v3

```
docker secret create java-context ./secrets/context.xml
```

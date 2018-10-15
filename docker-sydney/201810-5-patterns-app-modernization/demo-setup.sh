#!/bin/bash

# Switch to UCP

cd /mnt/c/ucp/scee
eval "$(<env.sh)"
cd /mnt/c/scm/github/sixeyed/presentations/docker-sydney/201810-5-patterns-app-modernization

# Create configs & secrets for Java:

docker config create java-logging ./java/swarm/configs/logging.properties
docker config create java-web ./java/swarm/configs/web.xml
docker secret create java-context ./java/swarm/secrets/context.xml

# Create configs & secrets for .NET:

docker config create netfx-appsettings ./netfx/swarm/configs/appSettings.config
docker config create netfx-log4net ./netfx/swarm/configs/log4net.config
docker secret create netfx-connectionstrings ./netfx/swarm/secrets/connectionStrings.config
docker config create netfx-prometheus ./netfx/swarm/configs/prometheus.yml

# Deploy baseline apps:

docker stack deploy -c ./netfx/swarm/docker-stack-v0.yml netfx
docker stack deploy -c ./java/swarm/docker-stack-v1.yml java

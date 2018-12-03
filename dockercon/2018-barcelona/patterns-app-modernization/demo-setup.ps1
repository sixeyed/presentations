# Switch to UCP
. /ucp/scee/env.ps1

# Create configs & secrets for .NET:
docker config create netfx-appsettings ./netfx/swarm/configs/appSettings.config
docker config create netfx-log4net ./netfx/swarm/configs/log4net.config
docker secret create netfx-connectionstrings ./netfx/swarm/secrets/connectionStrings.config
docker config create netfx-prometheus ./netfx/swarm/configs/prometheus.yml
docker secret create sqlserver-sapassword ./netfx/swarm/secrets/sql-server-sa-password.txt

# Deploy baseline apps:
docker stack deploy -c ./netfx/swarm/docker-stack-v0.yml netfx
docker stack deploy -c ./java/swarm/docker-stack-v1.yml java


$dbIP ='172.31.118.85'
$connectionString="Server=$dbIP;Database=ProductLaunch;User Id=sa;Password=DockerCon!!!"
$env:DB_CONNECTION_STRING=$connectionString
[System.Environment]::SetEnvironmentVariable('DB_CONNECTION_STRING', $connectionString)

docker container run --ip $dbIP --detach `
 -p 1433:1433 --name sql `
 -e ACCEPT_EULA=Y -e sa_password=DockerCon!!! `
 microsoft/mssql-server-windows-express;
# Kubernetes with Windows Nodes on AKS

Instructions for demo setup using [az]().

## RG 

Create resource group:

```
az group create --name dotnetconf2020 --location eastus
```

## AKS

Create cluster:

```
az aks create -g dotnetconf2020 -n dotnetconf-aks `
 --node-count 2 --kubernetes-version 1.17.7 `
 --load-balancer-sku Standard --network-plugin azure `
 --windows-admin-username kube --windows-admin-password "ag##dPA55w)rd]]"
```

Add Windows nodes:

```
az aks nodepool add `
    --resource-group dotnetconf2020 `
    --cluster-name dotnetconf-aks `
    --os-type Windows `
    --name akswin `
    --node-count 2 `
    --kubernetes-version 1.17.7
```

Get creds:

```
az aks get-credentials --resource-group dotnetconf2020 --name dotnetconf-aks
```

## Public IP

Create public IP for ingress (should use a different RG and assign SP permissions):

```
az network public-ip create `
    --resource-group MC_dotnetconf2020_dotnetconf-aks_eastus `
    --name dotnetconf2020-ip `
    --sku Standard `
    --allocation-method static
```

> Use the IP address in the [ingress controller service]().

## CosmosDB

Create account:

```
az cosmosdb create `
    --name petshop-cosmos-account `
    --resource-group dotnetconf2020 `
    --locations regionName=eastus
```

SQL database:

```
az cosmosdb sql database create `
    --account-name petshop-cosmos-account `
    --name petshop-db `
    --resource-group dotnetconf2020
```

Get connection details:

```
az cosmosdb list-connection-strings `
    --name petshop-cosmos-account `
    --resource-group dotnetconf2020
```

> Save the connection string in `./products-service/update/connection-string.yaml`
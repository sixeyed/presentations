# Kubernetes with Windows Nodes on AKS

Instructions for demo setup using [az]().

## RG 

Create resource group:

```
$rg = 'intmon2011'

az group create --name $rg --location eastus
```

## AKS

Create cluster:

```
$cluster = "$rg-aks"
$kubeversion = '1.17.11'
$winpwd = 'ridiculous-pasword'

az aks create -g $rg -n $cluster `
 --node-count 2 --kubernetes-version $kubeversion `
 --load-balancer-sku Standard --network-plugin azure `
 --windows-admin-username kube --windows-admin-password $winpwd
```

Add Windows nodes:

```
az aks nodepool add `
    --resource-group $rg `
    --cluster-name $cluster `
    --os-type Windows `
    --name akswin `
    --node-count 2 `
    --kubernetes-version $kubeversion
```

Get creds:

```
az aks get-credentials --resource-group $rg --name $cluster
```

## Public IP

Create public IP for ingress (TODO - should use a different RG and assign SP permissions):

```
$aksrg = "MC_$($rg)_$($cluster)_eastus"
$ip = "$cluster-ip"

az network public-ip create `
    --resource-group $aksrg `
    --name $ip `
    --sku Standard `
    --allocation-method static
```

> Use the IP address and AKS RG name in the [ingress controller service](ingress-controller/nginx-ingress-service.yaml).

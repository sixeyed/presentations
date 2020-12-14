# Kubernetes with Windows Nodes on AKS

Instructions for demo setup using [az]().

## Set variables

```
$rg = 'ps2012'
$kubeversion = '1.18.10'
$winpwd = 'iFQf##53365ANuprA5Q75'
```

## RG 

Create resource group:

```
az group create --name $rg --location eastus
```

## AKS

Create cluster:

```
$cluster = "$rg-aks"

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

> Use the IP address and AKS RG name in the [ingress controller service](petshop/kubernetes/ingress-controller/nginx-ingress-service.yaml).

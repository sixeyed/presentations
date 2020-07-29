## Kubernetes with Windows Nodes on AKS

Create resource group:

```
az group create --name dotnetconf2020 --location eastus
```



Create AKS cluster:

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

Create public IP for ingress (should use a different RG and assign SP permissions):

```
az network public-ip create `
    --resource-group MC_dotnetconf2020_dotnetconf-aks_eastus `
    --name dotnetconf2020-ip `
    --sku Standard `
    --allocation-method static
```
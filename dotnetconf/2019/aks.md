
> Source https://docs.microsoft.com/en-us/azure/aks/windows-container-cli

Preview extension:

```
az extension add --name aks-preview
az extension update --name aks-preview
```

Windows Preview feature:

```
az feature register --name WindowsPreview --namespace Microsoft.ContainerService
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/WindowsPreview')].{Name:name,State:properties.state}"
```

When ready:

```
az provider register --namespace Microsoft.ContainerService
```

RG:

```
az group create --name dotnetconf2019 --location eastus
```

Create a Service Principal for AKS:

```
az ad sp create-for-rbac --skip-assignment --name dotnetconf2019
```

Create AKS cluster:

> Add the creds from the Service Principal, and choose a good password for the Windows nodes

```
PASSWORD_WIN=""
SP_APP_ID=""
SP_PASSWORD=""

az aks create \
    --resource-group dotnetconf2019 \
    --name dotnetconf-aks \
    --node-count 2 \
    --enable-addons monitoring \
    --kubernetes-version 1.14.6 \
    --generate-ssh-keys \
    --windows-admin-password $PASSWORD_WIN \
    --windows-admin-username azureuser \
    --vm-set-type VirtualMachineScaleSets \
    --network-plugin azure \
    --enable-vmss \
    --service-principal $SP_APP_ID \
    --client-secret $SP_PASSWORD
```

AKS Windows Node Pool:

```
az aks nodepool add \
    --resource-group dotnetconf2019 \
    --cluster-name dotnetconf-aks \
    --os-type Windows \
    --name npwin \
    --node-count 2 \
    --kubernetes-version 1.14.6
```

Get creds and set up SP for dashboard:

```
az aks get-credentials --resource-group dotnetconf2019 --name dotnetconf-aks

kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
```

Run dashboard:

```
az aks browse --resource-group dotnetconf2019 --name dotnetconf-aks
```

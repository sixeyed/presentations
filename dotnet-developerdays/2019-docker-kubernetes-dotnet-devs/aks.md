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
APP_NAME="netdd19"
az group create --name $APP_NAME --location westeurope
```

Create a Service Principal for AKS:

```
az ad sp create-for-rbac --skip-assignment --name $APP_NAME
```

Create AKS cluster:

> Add the creds from the Service Principal, and choose a good password for the Windows nodes

```
PASSWORD_WIN="x"
SP_APP_ID="x"
SP_PASSWORD="x"

az aks create \
    --resource-group $APP_NAME \
    --name "$APP_NAME-aks" \
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
    --resource-group $APP_NAME \
    --cluster-name "$APP_NAME-aks" \
    --os-type Windows \
    --name npwin \
    --node-count 2 \
    --kubernetes-version 1.14.6
```

Get creds and set up SP for dashboard:

```
az aks get-credentials --resource-group $APP_NAME --name "$APP_NAME-aks"

kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
```

Run dashboard:

```
APP_NAME="netdd19"
az aks browse --resource-group $APP_NAME --name "$APP_NAME-aks"
```

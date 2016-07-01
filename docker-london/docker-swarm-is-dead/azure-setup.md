
##Creating VMs in Azure to use for your Docker Swarm


###Setup

First you need your SSH key as a PEM file (assumes you have a default key already in ~/.ssh). This is the key you will use to access swarm nodes with SSH, Azure just needs it in PEM format when it creates the VMs.

```
openssl req -x509 -key ~/.ssh/id_rsa -nodes -days 365 -newkey rsa:2048 -out ~/.ssh/id_rsa.pem
```

Now spin up the container and copy in the PEM file:

```
docker run -it --rm --name azure-cli microsoft/azure-cli
docker cp ~/.ssh/id_rsa.pem azure-cli:/swarm.pem
```

###Login

Inside the container, run

```
azure login
```

- and follow the instructions (copying the unique code for that session into a browser to authenticate).


###Create Azure components

The following commands all run inside the container.

Create the Resource Group:

```
azure group create --name badapi-swarm --location "North Europe"
```

Create the first VM, which will be the master - defaults to IP 10.0.0.4:

```

azure vm create --resource-group badapi-swarm --vm-size Standard_D1_v2 --location "North Europe" --admin-username elton \
--vnet-name badapi-swarm-vnet --vnet-address-prefix 10.0.0.0/24 --vnet-subnet-name badapi-swarm-subnet --vnet-subnet-address-prefix 10.0.0.0/24 \
--os-type Linux --availset-name badapi-swarm-as --ssh-publickey-file /swarm.pem --image-urn Canonical:UbuntuServer:16.04.0-LTS:latest --storage-account-name swarmstorage \
--nic-name badapi-swarm-00 -n badapi-swarm-00 --public-ip-name badapi-swarm-00 --public-ip-domain-name badapi-swarm-00

```

Now create the workers (this can be done in parallel on multiple instances of the container):

```

azure vm create --resource-group badapi-swarm --vm-size Standard_D1_v2 --location "North Europe" --admin-username elton \
--vnet-name badapi-swarm-vnet --vnet-address-prefix 10.0.0.0/24 --vnet-subnet-name badapi-swarm-subnet --vnet-subnet-address-prefix 10.0.0.0/24 \
--os-type Linux --availset-name badapi-swarm-as --ssh-publickey-file /swarm.pem --image-urn Canonical:UbuntuServer:16.04.0-LTS:latest --storage-account-name swarmstorage \
--nic-name badapi-swarm-01 -n badapi-swarm-01 --public-ip-name badapi-swarm-01 --public-ip-domain-name badapi-swarm-01

azure vm create --resource-group badapi-swarm --vm-size Standard_D1_v2 --location "North Europe" --admin-username elton \
--vnet-name badapi-swarm-vnet --vnet-address-prefix 10.0.0.0/24 --vnet-subnet-name badapi-swarm-subnet --vnet-subnet-address-prefix 10.0.0.0/24 \
--os-type Linux --availset-name badapi-swarm-as --ssh-publickey-file /swarm.pem --image-urn Canonical:UbuntuServer:16.04.0-LTS:latest --storage-account-name swarmstorage \
--nic-name badapi-swarm-02 -n badapi-swarm-02 --public-ip-name badapi-swarm-02 --public-ip-domain-name badapi-swarm-02

azure vm create --resource-group badapi-swarm --vm-size Standard_D1_v2 --location "North Europe" --admin-username elton \
--vnet-name badapi-swarm-vnet --vnet-address-prefix 10.0.0.0/24 --vnet-subnet-name badapi-swarm-subnet --vnet-subnet-address-prefix 10.0.0.0/24 \
--os-type Linux --availset-name badapi-swarm-as --ssh-publickey-file /swarm.pem --image-urn Canonical:UbuntuServer:16.04.0-LTS:latest --storage-account-name swarmstorage \
--nic-name badapi-swarm-03 -n badapi-swarm-03 --public-ip-name badapi-swarm-03 --public-ip-domain-name badapi-swarm-03

azure vm create --resource-group badapi-swarm --vm-size Standard_D1_v2 --location "North Europe" --admin-username elton \
--vnet-name badapi-swarm-vnet --vnet-address-prefix 10.0.0.0/24 --vnet-subnet-name badapi-swarm-subnet --vnet-subnet-address-prefix 10.0.0.0/24 \
--os-type Linux --availset-name badapi-swarm-as --ssh-publickey-file /swarm.pem --image-urn Canonical:UbuntuServer:16.04.0-LTS:latest --storage-account-name swarmstorage \
--nic-name badapi-swarm-04 -n badapi-swarm-04 --public-ip-name badapi-swarm-04 --public-ip-domain-name badapi-swarm-04

```

Configure subnet security:

```
azure network nsg create --resource-group badapi-swarm --location "North Europe" --name badapi-swarm-nsg

azure network nsg rule create --resource-group badapi-swarm --nsg-name badapi-swarm-nsg \
--name "Allow-Http" --priority 100 --description "Public HTTP" \
--direction Inbound --protocol Tcp --source-address-prefix Internet --destination-address-prefix VirtualNetwork --destination-port-range 80 --access Allow

azure network nsg rule create --resource-group badapi-swarm --nsg-name badapi-swarm-nsg \
--name "Allow-Kibana" --priority 120 --description "Public Kibana" \
--direction Inbound --protocol Tcp --source-address-prefix Internet --destination-address-prefix VirtualNetwork --destination-port-range 5601 --access Allow

azure network nsg rule create --resource-group badapi-swarm --nsg-name badapi-swarm-nsg \
--name "Allow-Ssh" --priority 130 --description "Public SSH" \
--direction Inbound --protocol Tcp --source-address-prefix Internet --destination-address-prefix VirtualNetwork --destination-port-range 22 --access Allow

azure network vnet subnet set --resource-group badapi-swarm --vnet-name badapi-swarm-vnet --name badapi-swarm-subnet --network-security-group-name badapi-swarm-nsg

```

Create public-facing load balancer & rules:


```
azure network public-ip create --resource-group badapi-swarm --location "North Europe" --name badapi-swarm-pip --domain-name-label badapi-swarm-public

azure network lb create --resource-group badapi-swarm --location "North Europe" --name badapi-swarm-nlb

azure network lb frontend-ip create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name badapi-swarm-fip --public-ip-name badapi-swarm-pip 

azure network lb address-pool create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name badapi-swarm-bep

azure network lb probe create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name lb-probe-http --protocol Tcp --port 80 --interval 20 --count 3

azure network lb rule create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name lb-http --protocol Tcp --frontend-port 80 --backend-port 80 --frontend-ip-name badapi-swarm-fip --backend-address-pool-name badapi-swarm-bep --probe-name lb-probe-http

azure network lb probe create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name lb-probe-kibana --protocol Tcp --port 5601 --interval 20 --count 3

azure network lb rule create --resource-group badapi-swarm --lb-name badapi-swarm-nlb --name lb-kibana --protocol Tcp --frontend-port 5601 --backend-port 5601 --frontend-ip-name badapi-swarm-fip --backend-address-pool-name badapi-swarm-bep --probe-name lb-probe-kibana

```

### Now install Docker, following [docker-setup](docker-setup.md).
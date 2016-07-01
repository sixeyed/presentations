
##Prep VMs to run your Docker Swarm


###Setup

Assumes you have VMs created with [azure-setup](azure-setup.md), but they could be any VMs.

Commands are tested on Ubuntu Xenial.


### On all VMs

Install the test version of Docker - currently 1.12RC2

```
ssh badapi-swarm-00.northeurope.cloudapp.azure.com 

curl -fsSL https://test.docker.com/ | sh

sudo usermod -aG docker elton
```

To save time running the demos, you can pull the images in advance. Not required, as Docker will pull them as necessary:

```
docker pull ubuntu && docker pull redis && docker pull elasticsearch && docker pull kibana && docker pull sixeyed/badapi-api && docker pull sixeyed/badapi-indexer && docker pull sixeyed/ubuntu-with-utils
```



### Now you can follow along with the demos, using [demo-cheatsheet](demo-cheatsheet.md).


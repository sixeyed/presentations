##Docker Swarm Mode Demo

For the session I used VMs running in Azure, and the setup in this repo is exactly what I used.

You can replicate this if you have an Azure subscription, just by following along - although you'll need to use different component names (just replace 'badapi-swarm' with your own prefix).

I use the Azure CLI which is available as a Docker container, so you can spin it up and run the cross-platform CLI without installing any software, but it's a bit fiddly to run an automated script. So the [azure-setup](azure-setup.md) file documents steps to run interactively, once you've signed into the CLI.

Then you can set up Docker on your VMs by following [docker-setup](docker-setup.md).

The actual demo steps are in [demo-cheatsheet](demo-cheatsheet.md) and they're split up to match the different demos in the original presentation.

That presentation is on SlideShare here: [Docker Swarm Is Dead. Long Live Docker Swarm](http://www.slideshare.net/sixeyed/docker-swarm-is-dead-long-live-docker-swarm).

You don't need to build the custom 'badapi' images, as they're available on the Docker Hub, but the source code is here if you want to.

Feedback is always welcome - @EltonStoneman on Twitter.
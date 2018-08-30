#!/bin/bash

cd ~/ucp/eecus4/ucp-bundle-admin

eval "$(<env.sh)"

export DOCKER_ORCHESTRATOR='swarm'

cd ~/scm/github/sixeyed/presentations/pluralsight-live/2018-why-containers-take-over-world/apps
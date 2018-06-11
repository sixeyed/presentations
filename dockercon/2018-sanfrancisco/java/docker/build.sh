#!/bin/bash

docker image build -t sixeyed/dcsf-java:v1 -f ./v1/Dockerfile .

docker image build -t sixeyed/dcsf-java:v2 -f ./v2/Dockerfile .

docker image build -t sixeyed/dcsf-java:v3 -f ./v3/Dockerfile .

docker image build -t sixeyed/dcsf-java:v4 -f ./v4/Dockerfile .

docker image build -t sixeyed/dcsf-java:v5 -f ./v5/Dockerfile .
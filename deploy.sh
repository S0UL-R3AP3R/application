#!/bin/bash

set -e

CONTAINER_NAME="alpine_timeoff"

#Check for running container & stop it before starting a new one
if [[ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}) = "true" ]]; then
    sudo docker stop alpine_timeoff
fi

echo "Building Image"
sudo docker build --rm -t timeoff:latest --no-cache .
echo "Running Docker Container using Docker Image name: timeoff:latest"
sudo docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff

sudo docker ps -a
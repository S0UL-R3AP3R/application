#!/bin/bash

set -e

DOCKER_IMAGE="timeoff:latest"
CONTAINER_NAME="alpine_timeoff"

# Check for arguments
if [[ $# -lt 1 ]] ; then
    sudo docker build --rm -t timeoff:latest --no-cache .
    exit 1
fi

echo "Deploying App to Docker Container"

#Check for running container & stop it before starting a new one
if [[ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}) = "true" ]]; then
    sudo docker stop alpine_timeoff
fi

echo "Starting App using Docker Image name: $DOCKER_IMAGE"

sudo docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff

sudo docker ps -a
!/bin/bash

set -e

DOCKER_IMAGE= $1
CONTAINER_NAME="alpine_timeoff"

# Check for arguments
if [[ $# -lt 1 ]] ; then
    echo '[ERROR] You must supply a Docker Image to pull'
    exit 1
fi

echo "Deploying App to Docker Container"

#Check for running container & stop it before starting a new one
if [[ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}) = "true" ]]; then
    docker stop alpine_timeoff
fi

echo "Starting App using Docker Image name: $DOCKER_IMAGE"

docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff

docker ps -a
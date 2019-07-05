#!/bin/bash

cd /var/www/

set -e

DOCKER_IMAGE="timeoff:latest"
CONTAINER_NAME="alpine_timeoff"

# Check for existing image
if [[ "$(sudo docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
        echo 'Building Image:'
        sudo docker build --rm -t timeoff:latest --no-cache .
        echo "Starting App using Docker Image name: $CONTAINER_NAME"
        sudo docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff
        sudo docker ps -a
fi

sudo docker stop $(sudo docker ps -aqf "name=${CONTAINER_NAME}")
sudo docker rm $(sudo docker ps -aqf "name=${CONTAINER_NAME}")
sudo docker rmi -f $(sudo docker images --filter=reference=timeoff --format "{{.ID}}") $(sudo docker images --filter=reference=alpine --format "{{.ID}}")
sudo docker build --rm -t timeoff:latest --no-cache .

echo "Starting App using Docker Image name: $CONTAINER_NAME"
sudo docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff
sudo docker ps -a
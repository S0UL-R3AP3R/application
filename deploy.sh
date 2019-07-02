#!/bin/bash

set -e

DOCKER_IMAGE="timeoff:latest"
CONTAINER_NAME="alpine_timeoff"

#sudo apt install -y httpd

# Check for existing image
if [[ "$(sudo docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
            echo 'Building Image:'
            sudo docker build --rm -t timeoff:latest --no-cache .
                exit 1
fi

#Check for running container & stop it before starting a new one
if [ "$(sudo docker ps -aq -f status=running -f name=${CONTAINER_NAME})" ]; then
       echo "Container already exist, cleaning up"
        sudo docker stop $(sudo docker ps -aqf "name=${CONTAINER_NAME}")

        if [ "$(sudo docker ps -aq -f status=exited -f name=${CONTAINER_NAME})" ]; then
                echo "Removing Existing Container"
                sudo docker rm $(sudo docker ps -aqf "name=${CONTAINER_NAME}")

        fi

#        echo "Starting App using Docker Image name: $CONTAINER_NAME"
        sudo docker run -t -i -d -p 3000:3000 --name alpine_timeoff timeoff
        sudo docker ps -a
fi

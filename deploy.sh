!/usr/bin/env bash
########################################
# Put this on a Server
# run chmod +x deploy_app.sh to make the script executable
#
# Execute this script:  ./deploy_app.sh ariv3ra/python-circleci-docker:$TAG
# Replace the $TAG with the actual Build Tag you want to deploy
#
########################################

set -e

DOCKER_IMAGE= "timeoff:latest"
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
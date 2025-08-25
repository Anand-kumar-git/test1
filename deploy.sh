#!/bin/bash

IMAGE_NAME="static-web"
CONTAINER_NAME="static_application"

# Stop & remove old container if it exists
docker rm -f $CONTAINER_NAME 2>/dev/null || true

# Run a new container on port 9091
docker run -idt -p 9091:80 --name $CONTAINER_NAME $IMAGE_NAME

#! /bin/bash 

IMAGE_NAME="static-web"

CONTAINER_NAME="static_application"

docker rm -f $CONTAINER_NAME 2>/dev/null || true

docker run -idt -p "9091:80" --name $CONTAINER_NAME $IMAGE_NAME
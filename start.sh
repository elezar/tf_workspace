#!/bin/bash

# Determine the name of the current user.
USERNAME=$(whoami)

DOCKER_IMAGE=tf_devel
DOCKER_FILE=Dockerfile

GPU=${GPU:-0}

if [ "$GPU" != "1" ]
then
TAG=cpu
DOCKER_EXE=docker
else
TAG=gpu
DOCKER_EXE=nvidia-docker
fi

DOCKER_IMAGE=$DOCKER_IMAGE:$TAG
DOCKER_FILE=$DOCKER_FILE.$TAG

# Construct a hostname from the image name.
DOCKER_HOSTNAME=${DOCKER_IMAGE//_/-}
DOCKER_HOSTNAME=${DOCKER_HOSTNAME//:/-}

# First ensure that the docker image is built.
$DOCKER_EXE build --build-arg user_id=$(id -u) \
            --build-arg group_id=$(id -g) \
            --build-arg user_name=$USERNAME \
            -t $DOCKER_IMAGE -f $DOCKER_FILE .

# If the build succeeded.
if [ "$?" -eq 0 ]; then
# Create a temporary home folder. This ensures that the permissions are
# correct.
mkdir -p .home/$USERNAME

$DOCKER_EXE run --rm -ti \
            -h "$DOCKER_HOSTNAME" \
			-u $(id -u):$(id -g) \
			-w /workspace \
			-v $(pwd):/workspace \
			-v $(pwd)/.home/$USERNAME:/home/$USERNAME \
			-p 8888:8888 \
			-p 6006:6006 \
			$DOCKER_IMAGE $*
fi
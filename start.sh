#!/bin/bash

DOCKER_IMAGE=tf_devel

# First ensure that the docker image is built.
docker build --build-arg user_id=$(id -u) \
            --build-arg group_id=$(id -g) \
            --build-arg user_name=$(whoami) \
            -t $DOCKER_IMAGE .

if [ "$?" -eq 0 ]; then
docker run --rm -ti \
            -h "${DOCKER_IMAGE/_/-}" \
			-u $(id -u):$(id -g) \
			-w /workspace \
			-v $(pwd):/workspace \
			-v $(pwd)/.home:/home/$(whoami) \
			-p 8888:8888 -p 6006:6006 \
			$DOCKER_IMAGE
fi
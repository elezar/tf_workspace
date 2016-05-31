# TensorFlow Workspace
A workspace for using TensorFlow.

## Getting started
Simply run:
```
./start.sh
```
This will:

1. Build a local Docker image based on the latest TensorFlow image (gcr.io/tensorflow/tensorflow).
2. Start a Docker container based on the image to run TensorFlow.

## What makes this special?
Although one can run a container based on the base TensorFlow image, this workspace has some nice features. These include:

1. A user with the same name, id, and group id as the current user is create in the container.
2. The `.home/[USERNAME]` folder is mapped to `/home/username` in the container. This means that things like shell history are persisted between runs.
3. The current folder is mapped to the `/workspace` folder in the container.
4. The container is started as a user with the same user and group id as the current user. This means that the file and folder permissions should be similar to if TensorFlow was being run on the host system.

## Requirements

- Docker (due to the user and group id flags, native docker is required on Mac and Windows)

## TODO:
- [ ] GPU support
- [ ] Add TensorFlow repos (tensorflow, models) as submodules
- [ ] Add Support for building tensorflow in Docker.
- [ ] Add advanced usage options.
- [ ] Improve documentation
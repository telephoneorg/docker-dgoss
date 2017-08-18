#!/usr/bin/env bash

BASEDIR=$(dirname $0)
TESTDIR=$(realpath $BASEDIR)
IMAGE=joeblackwaslike/dgoss:latest
COMMAND=$(basename $0)

docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $TESTDIR:/tests \
    -v /tmp:/tmp \
    $IMAGE \
    dgoss $COMMAND "$@"
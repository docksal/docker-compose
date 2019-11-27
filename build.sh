#!/bin/bash

COMPOSE_VERSION=${COMPOSE_VERSION:-1.25.0}

TAG="docksal/docker-compose:${COMPOSE_VERSION}"

docker build -t "${TAG}" -f ${COMPOSE_VERSION}/Dockerfile ./${COMPOSE_VERSION} --build-arg COMPOSE_VERSION=${COMPOSE_VERSION}

mkdir -p ${COMPOSE_VERSION}/bin/alpine/
TMP_CONTAINER=$(docker create "${TAG}")
docker cp "${TMP_CONTAINER}":/usr/local/bin/docker-compose "${COMPOSE_VERSION}/bin/alpine/"
docker container rm -f "${TMP_CONTAINER}"
docker image rm -f "${TAG}"

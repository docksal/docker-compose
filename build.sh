#!/bin/bash

COMPOSER_VERSION="1.25.0"
pwd=$(pwd)
git clone -b ${COMPOSER_VERSION} https://github.com/docker/compose.git /tmp/docker-compose
cp linux-alpine /tmp/docker-compose/script/build/
cd /tmp/docker-compose/
./script/build/linux-alpine
mkdir -p ${pwd}/bin/alpine/${COMPOSER_VERSION}
cp dist/docker-compose-Linux-$(uname -m) ${pwd}/bin/alpine/${COMPOSER_VERSION}/docker-compose
cd ${pwd}
rm -rf /tmp/docker-compose/
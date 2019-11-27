#!/bin/bash

rm -rf /tmp/docker-compose/
COMPOSER_VERSION="1.24.1"
pwd=$(pwd)
git clone -b ${COMPOSER_VERSION} https://github.com/docker/compose.git /tmp/docker-compose
cp linux-alpine /tmp/docker-compose/script/build/
cd /tmp/docker-compose/
./script/build/linux-alpine
mkdir -p ${pwd}/bin/alpine/
cp dist/docker-compose-Linux-$(uname -m) ${pwd}/bin/alpine/docker-compose
cd ${pwd}
rm -rf /tmp/docker-compose/

git add -A
git commit -m "Build version ${COMPOSER_VERSION}"
git tag v${COMPOSER_VERSION}
git push origin v${COMPOSER_VERSION}
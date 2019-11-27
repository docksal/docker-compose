ARG COMPOSE_VERSION=1.25.0
ARG DOCKER_VERSION=18.09.7
ARG PYTHON_VERSION=3.6
ARG ALPINE_VERSION=3.10

ARG BUILD_PLATFORM=alpine

FROM docker:${DOCKER_VERSION} AS docker-cli

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION} AS build-alpine
RUN apk add --no-cache \
    bash \
    git \
    build-base \
    ca-certificates \
    curl \
    gcc \
    git \
    libc-dev \
    libffi-dev \
    libgcc \
    make \
    musl-dev \
    openssl \
    openssl-dev \
    python2 \
    python2-dev \
    python3-dev \
    zlib-dev
ENV BUILD_BOOTLOADER=1

FROM build-${BUILD_PLATFORM} AS build
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker
WORKDIR /code/
# FIXME(chris-crone): virtualenv 16.3.0 breaks build, force 16.2.0 until fixed
RUN pip install virtualenv==16.2.0
RUN pip install tox==2.9.1
ARG COMPOSE_VERSION
RUN git clone https://github.com/docker/compose.git . && \
    git checkout tags/${COMPOSE_VERSION} -b tmp && \
    tox --notest
COPY linux-entrypoint /
RUN /linux-entrypoint

FROM alpine:${ALPINE_VERSION} AS runtime-alpine
FROM runtime-${BUILD_PLATFORM} AS runtime

COPY --from=docker-cli  /usr/local/bin/docker           /usr/local/bin/docker
COPY --from=build       /usr/local/bin/docker-compose   /usr/local/bin/docker-compose

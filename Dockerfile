FROM    telephoneorg/debian:stretch

MAINTAINER Joe Black <me@joeblack.nyc>

ARG     DOCKER_VERSION
ARG     DGOSS_VERSION

ENV     DOCKER_VERSION=${DOCKER_VERSION:-17.03.0}
ENV     DGOSS_VERSION=${DGOSS_VERSION:-0.3.4}

ADD     https://github.com/aelsabbahy/goss/releases/download/v${DGOSS_VERSION}/dgoss /usr/local/bin/
RUN     chmod 0755 /usr/local/bin/dgoss

RUN     apt-get update -qq && \
            apt-get install -y curl ca-certificates && \
            apt-clean --aggressive && \
            cd /tmp && \
            curl -LO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}-ce.tgz && \
            tar -xzvf docker-${DOCKER_VERSION}-ce.tgz && \
            chmod +x docker/docker && \
            mv docker/docker /usr/local/bin/ && \
            rm -rf docker*

VOLUME  ["/tests"]

WORKDIR /tests

ENTRYPOINT ["/dumb-init", "--"]

CMD     ["dgoss"]

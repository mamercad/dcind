# Inspired by https://github.com/mumoshu/dcind
FROM alpine:3.13
LABEL maintainer="Dmitry Matrosov <amidos@amidos.me>"

ENV DOCKER_VERSION=18.09.8 \
    DOCKER_COMPOSE_VERSION=1.24.1

RUN apk --no-cache add gcc musl-dev python3-dev libffi-dev openssl-dev cargo

# Install Docker and Docker Compose
RUN apk --no-cache add bash curl util-linux device-mapper py3-pip python3-dev libffi-dev openssl-dev gcc libc-dev make iptables && \
    curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
    mv /docker/* /bin/ && \
    chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    rm -rf /root/.cache

RUN apk --no-cache add ansible==2.10.6-r0 git

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

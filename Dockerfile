FROM amazonlinux as builder
MAINTAINER Erica Windisch <erica@iopipe.com>
ARG NODE_VERSION=8.10.0

RUN yum groupinstall -yq "Development Tools"

# The /var/lang is where AWS installs Node.
#ADD https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz /tmp/
RUN mkdir -p /tmp; \
    curl -vvv https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz | \
    tar -zxvC /tmp/
WORKDIR /tmp/node-v${NODE_VERSION}
RUN mkdir -p /var/lang; \
    ./configure --prefix=/var/lang; \
    make all install

FROM amazonlinux
COPY --from=builder /var/lang /var/lang

RUN yum groupinstall -yq "Development Tools"

RUN mkdir -p /var/task
WORKDIR /var/task
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lang/bin
ENTRYPOINT ["npm", "install"]

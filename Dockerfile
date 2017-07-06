FROM amazonlinux
MAINTAINER Erica Windisch <erica@iopipe.com>
ARG NODE_VERSION=6.10.2

RUN yum groupinstall -yq "Development Tools"

# The /var/lang is where AWS installs Node.
#ADD https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz /tmp/
RUN mkdir -p /tmp; \
    curl -vvv https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz | \
    tar -zxvC /tmp/
WORKDIR /tmp/node-v${NODE_VERSION}
ENV MAKE make -j4
RUN alias make=${MAKE} mkdir -p /var/lang; \
    ./configure --prefix=/var/lang; \
    $MAKE all install

RUN mkdir -p /var/task
WORKDIR /var/task
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lang/bin
ENTRYPOINT ["npm", "install"]

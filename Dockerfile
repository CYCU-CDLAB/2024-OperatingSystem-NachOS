FROM --platform=linux/amd64 amd64/centos:centos7.9.2009

ARG DOCKER_SHELL=bash

COPY usr/local/nachos /usr/local/nachos
# Replace the default CentOS-Base.repo with the one that has the correct mirror after centos is EOL
COPY docker/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
# Install the necessary packages
COPY docker/pkg /usr/local/pkg
WORKDIR /usr/local/pkg
RUN yum localinstall -y --disablerepo=* *.rpm
# Clean up the yum cache
RUN yum clean all && \
    rm -rf /var/cache/yum/* && \
    rm -rf /usr/local/pkg
# Make g++44 the default g++
RUN ln -s /usr/bin/g++44 /usr/bin/g++

# Install oh-my-bash for a better shell experience, but don't fail the build if it fails
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || true

WORKDIR /nachos/code/test

ENTRYPOINT [ "/bin/bash" ]

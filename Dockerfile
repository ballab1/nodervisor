ARG FROM_BASE=${DOCKER_REGISTRY:-ubuntu-s2.home:5000/}${CONTAINER_OS:-alpine}/supervisord:${BASE_TAG:-latest}
FROM $FROM_BASE

# name and version of this docker image
ARG CONTAINER_NAME=nodervisor
# Specify CBF version to use with our configuration and customizations
ARG CBF_VERSION

# include our project files
COPY build Dockerfile /tmp/

# set to non zero for the framework to show verbose action scripts
#    (0:default, 1:trace & do not cleanup; 2:continue after errors)
ENV DEBUG_TRACE=0


# zookeeper version being bundled in this docker image
ARG NODERVISOR_VERSION=master
LABEL version.nodervisor=$NODERVISOR_VERSION 


ARG NODERVISOR_USER=nodervisor
ENV NODERVISOR_HOME=/usr/local/nodervisor


# build content
RUN set -o verbose \
    && chmod u+rwx /tmp/build.sh \
    && /tmp/build.sh "$CONTAINER_NAME" "$DEBUG_TRACE" \
    && ([ "$DEBUG_TRACE" != 0 ] || rm -rf /tmp/*) 


WORKDIR $NODERVISOR_HOME

ENTRYPOINT [ "docker-entrypoint.sh" ]
#CMD ["$CONTAINER_NAME"]
CMD ["nodervisor"]

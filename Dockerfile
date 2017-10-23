FROM node:8.7.0-alpine

ARG TZ=UTC

COPY nodervisor.tgz /tmp

ENV VERSION=0.4 \
    BLD_PKGS="alpine-sdk" \
    CORE_PKGS="supervisor tzdata"

ADD docker-entrypoint.sh /

# Run-time Dependencies
RUN set -e \
    && apk update \
    && apk add --no-cache $CORE_PKGS $BLD_PKGS \
    && echo "$TZ" > /etc/TZ \
    && cp /usr/share/zoneinfo/$TZ /etc/timezone \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && cd /tmp \
    && tar xzf nodervisor.tgz \
    && cd nodervisor \
    && npm install node-gyp async express-session bcrypt connect-session-knex ejs express knex mysql sqlite3 stylus supervisord \
    && npm install \
    && chmod u+rx,g+rx,o+rx,a-w /docker-entrypoint.sh \
    && apk del $BLD_PKGS

EXPOSE 3000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nodervisor"]

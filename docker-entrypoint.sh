#!/bin/sh


if [ "$1" = 'nodervisor' ]; then
    cd /tmp/nodervisor
    npm start
else
    exec $@
fi

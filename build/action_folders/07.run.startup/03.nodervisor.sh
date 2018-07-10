#!/bin/bash

if ! nodervisor.hasUIDchanged; then
    sed -i 's|crf.fixupDirectory "$WORKDIR"||' "$(crf.STARTUP)/99.logs.sh"
fi
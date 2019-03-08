#!/bin/bash

if ! nodervisor.hasUIDchanged; then
    [ -f "$(crf.STARTUP)/99.workdir.sh" ] && sed -ie 's|crf.fixupDirectory|#crf.fixupDirectory|g' "$(crf.STARTUP)/99.workdir.sh"
fi
#!/bin/sh

set -e
set +u

# Parse command-line options
. ./parseCMDOpts.sh "$@"

UNIX_SOCKET=""
if [ -z "${DEVICE_TELNET_PORT}" ]; then
    UNIX_SOCKET="true"
fi

if [ -z "${BASLER_INSTANCE}" ]; then
   BASLER_INSTANCE="1"
fi

set -u

# Run run*.sh scripts with procServ
if [ "${UNIX_SOCKET}" ]; then
    /usr/local/bin/procServ -f -n basler_acA1300_75gm_${BASLER_INSTANCE} -i ^C^D unix:./procserv.sock ./runBasleracA130075gm.sh "$@"
else
    /usr/local/bin/procServ -f -n basler_acA1300_75gm_${BASLER_INSTANCE} -i ^C^D ${DEVICE_TELNET_PORT} ./runBasleracA130075gm.sh "$@"
fi

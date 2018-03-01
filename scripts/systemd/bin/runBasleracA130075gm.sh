#!/usr/bin/env bash

set -u

if [ -z "$BASLER_INSTANCE" ]; then
    echo "BASLER_INSTANCE environment variable is not set." >&2
    exit 1
fi

export BASLER_CURRENT_PV_AREA_PREFIX=BASLER_${BASLER_INSTANCE}_PV_AREA_PREFIX
export BASLER_CURRENT_PV_DEVICE_PREFIX=BASLER_${BASLER_INSTANCE}_PV_DEVICE_PREFIX
export BASLER_CURRENT_SERIAL_NUMBER=BASLER_${BASLER_INSTANCE}_SERIAL_NUMBER
export BASLER_CURRENT_DEVICE_TELNET_PORT_SUFFIX=BASLER_${BASLER_INSTANCE}_TELNET_PORT_SUFFIX
# Only works with bash
export BASLER_PV_AREA_PREFIX=${!BASLER_CURRENT_PV_AREA_PREFIX}
export BASLER_PV_DEVICE_PREFIX=${!BASLER_CURRENT_PV_DEVICE_PREFIX}
export BASLER_SERIAL_NUMBER=${!BASLER_CURRENT_SERIAL_NUMBER}
export BASLER_DEVICE_TELNET_PORT=${PROCSERV_BASLER_PORT_PREFIX}${!BASLER_CURRENT_DEVICE_TELNET_PORT_SUFFIX}

if [ -z "${BASLER_CURRENT_DEVICE_TELNET_PORT_SUFFIX}" ]; then
    echo "TELNET port is not set." >&2
    exit 1
fi

./runProcServ.sh \
    -s "${BASLER_SERIAL_NUMBER}" \
    -P "${BASLER_PV_AREA_PREFIX}" \
    -R "${BASLER_PV_DEVICE_PREFIX}"


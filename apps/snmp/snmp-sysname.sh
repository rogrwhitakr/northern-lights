#!/usr/bin/env bash
# snmp-sysname.sh
# Usage: ./snmp-sysname.sh <subnet-prefix> <community> [version] [port]
#   subnet-prefix: e.g. 10.20.210 (scans 10.20.210.1 - 10.20.210.254)
#   community: SNMP community string, e.g. "public"
#   version: SNMP version (default: 2c), e.g. 2c or 1
#   port: SNMP port (default: 161)

set -euo pipefail

if [[ $# < 2 ]]; then
    echo "Usage: $0 <subnet-prefix> <community> [version] [port]"
    echo "  subnet-prefix: e.g. 10.20.210 (scans .1 - .254)"
    echo "  community: SNMP community string, e.g. public"
    echo "  version: SNMP version (default: 2c), e.g. 2c or 1"
    echo "  port: SNMP port (default: 161)"
    exit 1
fi

SUBNET_PREFIX="$1"
COMMUNITY="$2"
VERSION="${3:-2c}"
PORT="${4:-161}"

OID="1.3.6.1.2.1.1.5.0"

# Build base command options
BASE_OPTS="-v$VERSION"

if [[ "$VERSION" == "2c" ]]; then
    BASE_OPTS="$BASE_OPTS -c $COMMUNITY"
elif [[ "$VERSION" == "1" ]]; then
    BASE_OPTS="$BASE_OPTS -c $COMMUNITY"
else
    echo "Unsupported SNMP version: $VERSION (use 1 or 2c)"
    exit 1
fi

BASE_OPTS="$BASE_OPTS -p $PORT"

echo "# SNMP sysName scan on subnet $SUBNET_PREFIX.x"
echo "# Community: $COMMUNITY, Version: $VERSION, Port: $PORT, OID: $OID"
echo "# IP_Address                              sysName"
echo "#------------------------------------------------------------"

for last_octet in $(seq 1 254); do
    IP="$SUBNET_PREFIX.$last_octet"

    echo
    echo "[$IP] Starting SNMP query for OID $OID"

    RESULT=$(snmpget $BASE_OPTS -Oqv "$IP" "$OID" 2>/dev/null) || true

    if [[ -z "$RESULT" ]]; then
        echo "[$IP] No response received."
        continue
    fi

    echo "[$IP] Raw result: $RESULT"

    RESULT_NOQUOTE=$(printf '%s\n' "$RESULT" | sed 's/^"//' | sed 's/"$//')

    if [[ "$RESULT_NOQUOTE" == *"No Such Object"* ]] || [[ "$RESULT_NOQUOTE" == *"No Such Instance"* ]]; then
        echo "[$IP] Device responded, but the OID is not available."
        continue
    fi

    if [[ -n "$RESULT_NOQUOTE" ]]; then
        echo "[$IP] sysName detected successfully."
        echo "[$IP] sysName = $RESULT_NOQUOTE"
    else
        echo "[$IP] Response was empty after cleanup."
    fi
done

echo "# Scan complete."
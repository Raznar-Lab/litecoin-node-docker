#!/bin/sh
set -e

mkdir -p /app/data

# Defaults
: "${LTC_RPCUSER:=ltcadmin}"
: "${LTC_RPCPASSWORD:=supersecurepassword}"
: "${LTC_RPCBIND:=0.0.0.0}"
: "${LTC_RPCALLOWIP:=0.0.0.0/0}"
: "${LTC_TESTNET:=}"
: "${LTC_PRUNE:=550}"  # Prune mode default: ~550 MB

ARGS="-datadir=/app/data -server=1"
ARGS="$ARGS -rpcuser=${LTC_RPCUSER} -rpcpassword=${LTC_RPCPASSWORD}"
ARGS="$ARGS -rpcbind=${LTC_RPCBIND} -rpcallowip=${LTC_RPCALLOWIP}"
ARGS="$ARGS -prune=${LTC_PRUNE}"

if [ -n "$LTC_TESTNET" ]; then
  ARGS="$ARGS -testnet"
fi

litecoind $ARGS "$@"

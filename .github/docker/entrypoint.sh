#!/bin/bash
cd /app
set -e

# Defaults
: "${LTC_RPCUSER:=ltcadmin}"
: "${LTC_RPCPASSWORD:=supersecurepassword}"
: "${LTC_RPCBIND:=0.0.0.0}"
: "${LTC_RPCALLOWIP:=0.0.0.0/0}"
: "${LTC_TESTNET:=}"
: "${LTC_PRUNE:=550}"
: "${LTC_DATADIR:=$(pwd)/data}"

# Build args
ARGS=(
  -server=1
  -rpcuser="${LTC_RPCUSER}"
  -rpcpassword="${LTC_RPCPASSWORD}"
  -rpcbind="${LTC_RPCBIND}"
  -rpcallowip="${LTC_RPCALLOWIP}"
  -prune="${LTC_PRUNE}"
  -datadir="${LTC_DATADIR}"
)

# Enable testnet if requested
if [ "$LTC_TESTNET" = "1" ]; then
  ARGS+=("-testnet=1")
fi

# Start litecoind
exec litecoind "${ARGS[@]}" "$@"

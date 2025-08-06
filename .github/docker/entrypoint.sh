#!/bin/sh
set -e

mkdir -p /app/data

# Defaults
: "${LTC_RPCUSER:=ltcadmin}"
: "${LTC_RPCPASSWORD:=supersecurepassword}"
: "${LTC_RPCBIND:=0.0.0.0}"
: "${LTC_RPCALLOWIP:=0.0.0.0/0}"
: "${LTC_TESTNET:=}"
: "${LTC_PRUNE:=550}"

CONFIG_FILE="/app/litecoin.conf"

# Choose the correct config section
NETWORK_SECTION="[main]"
EXTRA_TESTNET=""

if [ "$LTC_TESTNET" = "1" ]; then
  NETWORK_SECTION="[test]"
  EXTRA_TESTNET="testnet=1"
fi

# Write config file
cat > "$CONFIG_FILE" <<EOF
$NETWORK_SECTION
server=1
$EXTRA_TESTNET
rpcuser=${LTC_RPCUSER}
rpcpassword=${LTC_RPCPASSWORD}
rpcbind=${LTC_RPCBIND}
rpcallowip=${LTC_RPCALLOWIP}
prune=${LTC_PRUNE}
EOF

# Launch litecoind with explicit bind (helps in Docker)
exec litecoind -datadir=/app/data -conf="$CONFIG_FILE" \
  -rpcbind=0.0.0.0 -rpcallowip=0.0.0.0/0 "$@"

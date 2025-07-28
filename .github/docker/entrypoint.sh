#!/bin/sh
set -e

mkdir -p /app/data

# Defaults
: "${LTC_RPCUSER:=ltcadmin}"
: "${LTC_RPCPASSWORD:=supersecurepassword}"
: "${LTC_RPCBIND:=0.0.0.0}"
: "${LTC_RPCALLOWIP:=0.0.0.0/0}"
: "${LTC_TESTNET:=}"
: "${LTC_PRUNE:=550}"  # ~550 MB

CONFIG_FILE="/app/data/litecoin.conf"

# Create the config file
cat > "$CONFIG_FILE" <<EOF
server=1
rpcuser=${LTC_RPCUSER}
rpcpassword=${LTC_RPCPASSWORD}
rpcbind=${LTC_RPCBIND}
rpcallowip=${LTC_RPCALLOWIP}
prune=${LTC_PRUNE}
EOF

if [ -n "$LTC_TESTNET" ]; then
  echo "testnet=1" >> "$CONFIG_FILE"
fi

exec litecoind -datadir=/app/data "$@"

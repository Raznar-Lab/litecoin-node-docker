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

# Create the config file
cat > "$CONFIG_FILE" <<EOF
[main]
server=1
rpcuser=${LTC_RPCUSER}
rpcpassword=${LTC_RPCPASSWORD}
rpcbind=${LTC_RPCBIND}
rpcallowip=${LTC_RPCALLOWIP}
prune=${LTC_PRUNE}
EOF

if [ "$LTC_TESTNET" = "1" ]; then
  cat >> "$CONFIG_FILE" <<EOF

[test]
testnet=1
rpcbind=${LTC_RPCBIND}
rpcallowip=${LTC_RPCALLOWIP}
EOF
fi


exec litecoind -datadir=/app/data -conf="$CONFIG_FILE" "$@"

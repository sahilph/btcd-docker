#!/bin/sh

if [ "$1" = "btcd" ] ; then
  # Manually generate certificate and add all domains, it is needed to connect to "btcd" over docker links.
  gencerts --host="*" --directory="/.btcd" || echo "Certificate and key already exists"
  set -- "$@" --rpccert="/.btcd/rpc.cert" --rpckey="/.btcd/rpc.key"
fi

exec "$@"

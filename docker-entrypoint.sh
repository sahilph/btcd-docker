#!/bin/sh

if [ "$1" = "btcd" ] ; then
  set -- "$@" -b "$BTCD_DIR/data" -C "$BTCD_DIR/btcd.conf" --logdir="$BTCD_DIR/logs"
fi

exec "$@"

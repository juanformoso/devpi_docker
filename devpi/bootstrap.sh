#!/usr/bin/env bash
set -e

[[ -f $DEVPISERVER_SERVERDIR/.serverversion ]] || initialize=yes

# Properly shutdown devpi server
shutdown() {
    devpi-server --stop  # Kill server
    kill -SIGTERM $TAIL_PID  # Kill log tailing
}

trap shutdown SIGTERM SIGINT

if [[ $initialize = yes ]]; then
  devpi-server --init
fi;

# uses DEVPISERVER_SERVERDIR which is set in the Dockerfile
devpi-server --start --host 0.0.0.0 --port $DEVPISERVER_PORT

DEVPI_LOGS=$DEVPISERVER_SERVERDIR/.xproc/devpi-server/xprocess.log

devpi use http://localhost:$DEVPISERVER_PORT
if [[ $initialize = yes ]]; then
  # Set root password
  devpi login root --password=''
  devpi user -m root password="${DEVPI_PASSWORD}"
fi;

tail -f $DEVPI_LOGS &
TAIL_PID=$!

# Wait until tail is killed
wait $TAIL_PID

# Set proper exit code
wait $DEVPI_PID
EXIT_STATUS=$?

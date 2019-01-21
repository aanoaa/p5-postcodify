#!/bin/sh
set -e
SERVER="$1"

SCRIPT="./app.pl"
if [ "$SERVER" = "morbo" ]; then
    OPTS="-v -l http://*:5000"
else
    SERVER="hypnotoad"
    OPTS="-f"
fi

$SERVER $OPTS $SCRIPT

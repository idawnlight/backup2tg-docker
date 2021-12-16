#!/bin/sh
set -e

if [ -z "${BOT_TOKEN}" ]; then
    echo "ERROR: BOT_TOKEN not set"
    exit
fi

if [ -z "${CHAT_ID}" ]; then
    echo "ERROR: CHAT_ID not set"
    exit
fi

if [ ! -z "${TZ}" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
    echo $TZ > /etc/timezone
fi

crond -f &

exec "$@"
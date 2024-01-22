#!/bin/sh

UP="Up"
STATUS=$(podman ps -f name=$1 --format '{{.Status}}')

if [[ "$STATUS" == *"$UP"* ]]; then
    echo "1"
else
    echo "0"
fi

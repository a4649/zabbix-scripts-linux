#!/bin/bash

STATE="$(systemctl is-active $1)"

if [[ $STATE == 'active' ]]; then
    echo "1"
else
    echo "0"
fi

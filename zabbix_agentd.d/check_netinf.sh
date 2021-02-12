#!/bin/bash

if ethtool $1 | grep yes > /dev/null
then
    echo "1"
else
    echo "0"
fi

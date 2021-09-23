#!/bin/bash

# only suported in NVIDIA GPUs
if [ ! -f "/usr/bin/nvidia-smi" ]
then
    echo 0
    exit 0
fi

/usr/bin/nvidia-smi -q -a | grep "GPU Current Temp" | awk -F'[^0-9]*' '$0=$2'
exit 0

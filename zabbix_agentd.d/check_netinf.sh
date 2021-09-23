#!/bin/bash

#######################################################################################################################################
#                                               Features:                                                                             #
# Operational status of network interfaces at Layer 2 of OSI model - https://en.wikipedia.org/wiki/OSI_model#Layer_2:_Data_Link_Layer #
# SFP / Optical Transceiver info like operational temperature, RX/TX optical power and errors                                         #
#######################################################################################################################################

INT=$1 #interface name
OPT=$2 #operation

if [ $OPT == "status" ]
then
    STATUS="$(ethtool $INT | grep "Link detected:" | awk -F ' ' '{print $3}')"
        if [ "$STATUS" == "yes" ]
        then
           echo "1" # Operational status is UP
        else
           echo "0" # Operational status is DOWN
        fi
fi

# Transceiver Optical TX power in dBm
if [ $OPT == "tx_power" ]
then
    ethtool -m $INT | grep -m1 "Laser output power" | awk -F ' ' '{print $8}'
fi

# Transceiver Optical RX power in dBm
if [ $OPT == "rx_power" ]
then
    ethtool -m $INT | grep -m1 "Receiver signal average optical power" | awk -F ' ' '{print $10}'
fi

# Transceiver operational temperaature in ºC
if [ $OPT == "temp" ]
then
    ethtool -m $INT | grep -m1 "Module temperature" | awk -F ' ' '{print $4}'
fi

# Ethernet speed of the link
if [ $OPT == "speed" ]
then
    ethtool $INT | grep -m1 "Speed:" | awk -F ' ' '{print $2}'
fi

# Ethernet RX errors
if [ $OPT == "rx_errors" ]
then
    ethtool -S $INT | grep HwIfInErrors | awk -F ' ' '{print $2}'
fi

# Ethernet TX errors
if [ $OPT == "tx_errors" ]
then
    ethtool -S $INT | grep HwIfOutErrors | awk -F ' ' '{print $2}'
fi


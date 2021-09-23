#!/bin/bash

#CORES="$(lscpu | grep "Core(s) per socket:" | awk -F'[^0-9]*' '$0=$2')"
#SOCKETS="$(lscpu | grep "Socket(s):" | awk -F'[^0-9]*' '$0=$2')"
CPU="$(lscpu | grep "Vendor ID:" | awk -F ' ' '{print $3}')"

if [ "$CPU" = 'GenuineIntel' ]
then
   TEMP="$(sensors | grep Core | awk -F'[:+°]' '{avg+=$3}END{print avg/NR}')"
   printf "%.2f\n" $TEMP
   exit 0
fi

# for AMD in ASUS Motherboards
TEMP="$(sensors | awk -F'[:+°]' '/CPU Temperature/ {print $3}')"
if [ ! -z "$TEMP" ]
then
   echo $TEMP
   exit 0
fi

# for AMD in ASRock Motherboards
TEMP="$(sensors | awk -F'[:+°]' '/CPUTIN/ {print $3}')"
if [ ! -z "$TEMP" ]
then
   echo $TEMP
   exit 0
else #not supported
   echo 0
   exit 0
fi

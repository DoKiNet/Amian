#!/bin/bash

set -e

AMIAN_PARTITION=$(df | grep "/run/live/medium" | cut -d  ' ' -f 1)
DEVICE=${AMIAN_PARTITION:0:8}
PERSISTENT_PARTITION="$DEVICE"2

f1(){
	lsblk -p |grep $PERSISTENT_PARTITION
}

if  [ "$(f1)" ]; then
    echo " "$PERSISTENT_PARTITION FOUND
	mount $PERSISTENT_PARTITION /AMIAN_DATA
    echo " "$PERSISTENT_PARTITION MOUNTED IN /AMIAN_DATA
else
	echo " "$PERSISTENT_PARTITION NOT FOUND
    #creo la partizione sfruttando tutto lo spazio non allocato
    #/dev/sdb2
    #mkfs.ext4 -L AMIAN_DATA /dev/sdb2
	#mount DEVICE2 /AMIAN_DATA
fi

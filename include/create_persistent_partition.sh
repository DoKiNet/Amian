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
    chown -R user:user /AMIAN_DATA
    chmod -R 777 /AMIAN_DATA
    echo " "$PERSISTENT_PARTITION MOUNTED IN /AMIAN_DATA
else
	echo " "$PERSISTENT_PARTITION NOT FOUND
    fdisk $DEVICE << EOF
n




w
q
EOF
    mkfs.ext4 -L AMIAN_DATA -F $PERSISTENT_PARTITION
    echo " "$PERSISTENT_PARTITION CREATED
    mount $PERSISTENT_PARTITION /AMIAN_DATA
	mkdir -p /AMIAN_DATA/DBox
    chown -R user:user /AMIAN_DATA
    chmod -R 777 /AMIAN_DATA
    echo " "$PERSISTENT_PARTITION MOUNTED IN /AMIAN_DATA
fi

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
	mount $PERSISTENT_PARTITION /media/user/AMIAN_DATA
    echo " "$PERSISTENT_PARTITION MOUNTED IN /media/user/AMIAN_DATA
else
	echo " "$PERSISTENT_PARTITION NOT FOUND
    fdisk $DEVICE << EOF
n




w
q
EOF
    mkfs.ext4 -L AMIAN_DATA -F $PERSISTENT_PARTITION
    echo " "$PERSISTENT_PARTITION CREATED
    mount $PERSISTENT_PARTITION /media/user/AMIAN_DATA
    echo " "$PERSISTENT_PARTITION MOUNTED IN /media/user/AMIAN_DATA
fi

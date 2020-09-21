#!/bin/bash

set -e

check_persistent_partition(){
    AMIAN_PARTITION=$(df | grep "/run/live/medium" | cut -d  ' ' -f 1)
    DEVICE=${AMIAN_PARTITION:0:8}
    PERSISTENT_PARTITION="$DEVICE"2
    if [ "$(df --output=source,target)" == "$PERSISTENT_PARTITION      /AMIAN_DATA" ]; then
        echo "1"
    else
        echo "0"
    fi
}

sudo su

if [ "$(check_persistent_partition)" == "1" ]; then
    echo ""
    echo "PERSISTENT PARTITION: FOUND"
elif [ "$(check_persistent_partition)" == "0" ]; then
    echo ""
    echo "PERSISTENT PARTITION: NOT FOUND"
    echo ""
    echo "I'M CREATING A PERSISTENT PARTITION ON UNALLOCATED SPACE..."
    /root/create_persistent_partition.sh
fi

if [ -d "/AMIAN_DATA/DBox/gvm11" ]; then
    echo ""
    echo "Directory \"/AMIAN_DATA/DBox/gvm11\": FOUND"
    dbox start gvm11
    lxc-attach -n gvm11 -- gvmi start gvm11
else
    cp /root/gvm11.dbox /AMIAN_DATA/Dbox/
    cd /AMIAN_DATA/Dbox/
    tar -xvzf gvm11.dbox
    rm gvm11.dbox
    dbox start gvm11
    lxc-attach -n gvm11 -- gvmi start gvm11
fi


IP=$(lxc-attach -n gvm11 -- hostname -I)
echo ""
echo "https://$IP:9392"
echo ""
su user -c "firefox https://$IP:9392"
#import ssl certificate in firefox

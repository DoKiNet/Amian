#!/bin/bash

set -e

check_persistent_partition(){
    AMIAN_PARTITION=$(df | grep "/run/live/medium" | cut -d  ' ' -f 1)
    DEVICE=${AMIAN_PARTITION:0:8}
    PERSISTENT_PARTITION="$DEVICE"2
    MOUNT_POINT="/AMIAN_DATA"
    if [ "$(df --output=source,target | grep $PERSISTENT_PARTITION | sed 's/ //g')" == "$PERSISTENT_PARTITION$MOUNT_POINT" ]; then
        echo "1"
    else
        echo "0"
    fi
}


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
    lxc-attach -n gvm11 -- env -C /root/gvmi ./gvmi start gvm11
else
    mkdir -p /AMIAN_DATA/DBox
    chmod -R 777 /AMIAN_DATA
    cd /AMIAN_DATA/DBox/
    wget https://sourceforge.net/projects/dbox-containers/files/gvm11.dbox/download -O gvm11.dbox
    sync; echo 1 > /proc/sys/vm/drop_caches
    nocache tar -xvJf gvm11.dbox
    rm gvm11.dbox
    sync; echo 1 > /proc/sys/vm/drop_caches
    dbox start gvm11
    sleep 10
    lxc-attach -n gvm11 -- env -C /root/gvmi ./gvmi start gvm11
fi

#i could add a while loop until IP!=null
IP=$(lxc-attach -n gvm11 -- hostname -I)
#here i have to clean the IP string removing spaces
echo ""
echo "https://$IP:9392"
echo ""
su user -c "firefox https://$IP:9392"
#import ssl certificate in firefox

#!/bin/bash

set -e

check_persistent_partition(){
    #to implement
    #find DEVICE2 mounted in /AMIAN_DATA
}

if [ "$(check_persistent_partition)" ]; then
    echo ""
    echo " PERSISTENT PARTITION: FOUND"
else
    echo ""
    echo " PERSISTENT PARTITION: NOT FOUND"
    echo " "
    echo " I'M CREATING A PERSISTENT PARTITION ON UNALLOCATED SPACE..."
    /root/create_persistent_partition.sh
fi

#if /AMIAN_DATA/Dbox/GVM11 found
#         dbox start gvm11
#         lxc-attach .. gvmi start gvm11
#else cp gvm11.dbox /AMIAN_DATA/Dbox/
#         tar -xvzf
#         dbox start gvm11
#         lxc-attach .. gvmi start gvm11

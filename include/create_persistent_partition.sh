#!/bin/bash

set -e

AMIAN_PARTITION=$(df | grep "/run/live/medium" | cut -d  ' ' -f 1)
DEVICE=${AMIAN_PARTITION:0:8}

f1(){
	lsblk|grep sdb2 #DEVICE2
}

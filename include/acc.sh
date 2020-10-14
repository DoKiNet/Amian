#!/bin/bash

yad --title="Amian  Control  Center" \
    --text="\nPersistent Partition: NOT FOUND" \
    --text-align="center"  \
    --button="Open":0 \
    --button="Create":1 \
    --button="Remove":2 \
    --button="Reset":3 \
    --button="Quit":4 \
    --buttons-layout="center"

#acc pp_create pp_open pp_remove pp_reset

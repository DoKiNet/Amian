#!/bin/bash

set -e

cd /AMIAN_DATA
wget https://www.torproject.org/dist/torbrowser/9.5.4/tor-browser-linux64-9.5.4_en-US.tar.xz
tar -xvJf tor-browser-linux64-9.5.4_en-US.tar.xz
rm tor-browser-linux64-9.5.4_en-US.tar.xz

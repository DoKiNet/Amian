#!/bin/bash

set -e

ret=$(zenity --entry --title="Amian" --text="Select your keyboard" --entry-text="us" it fr de es ru gb fi pt jp cn hu no ro se --cancel-label cancel --ok-label ok)


gsettings set org.gnome.desktop.input-sources sources "[('xkb', '$ret')]"

if [ "$ret" = "it" ]; then
               sudo ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime
            else
               sudo ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
fi



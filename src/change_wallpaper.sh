#!/bin/bash
#
# change_wallpaper.sh
#
# This script change the wallpaper in GNOME after a specific time from the
# folder defined in environment variable CWFOLDER or from ~/images folder.
#
# By default the lapse time to change wallpaper is 30 minutes. Can defined this
# period with the CWSLEEP environment variable (in minutes).
#

if [ -z "$CWFOLDER" ] ; then
    CWFOLDER="$HOME/images"
fi

if [ ! -d "$CWFOLDER" ] ; then
    echo "Please set the environment variable CWFOLDER with the images folder."
    exit 1
fi

if [ -z "$CWSLEEP" ] ; then
    CWSLEEP=30
elif ! [[ "$CWSLEEP" =~ ^[0-9]+$ ]] ; then
    echo "Error in CWSLEEP: $CWSLEEP not a number"
    exit 1
fi

while :
do
    WALLPAPER=$(ls $CWFOLDER | shuf -n 1)

    gsettings set org.gnome.desktop.background picture-uri "$CWFOLDER/$WALLPAPER"
    sleep ${CWSLEEP}m
done

exit 0

#!/bin/bash
#
# autoload.sh
#
# This script install/unsintall the file change_wallpaper.desktop in folder:
# ~/.config/autload
#
# Use:
# $ autoload.sh [on | off]
#

AUTOLOADFOLDER="$HOME/.config/autoload"

if [ ! -d "$AUTOLOADFOLDER" ] ; then
    echo "Folder is not accessible: $AUTOLOADFOLDER"
    exit 1
fi

CFGAUTOLOADFILE="$AUTOLOADFOLDER/change_wallpaper.desktop"

if [ "$1" == "on" ] ; then
    if [ -z "$CWFOLDER" ] ; then
        CWFOLDER="$HOME/images"
    fi

    if [ ! -d "$CWFOLDER" ] ; then
        echo "Please set the environment variable CWFOLDER with the images folder."
        exit 1
    fi

    SCRIPTFOLDER="$(cd "$( dirname $0 )" > /dev/null 2>&1 && pwd)"
    AUTOLOADFILE="${SCRIPTFOLDER}/change_wallpaper.desktop"
    FILECONTENT="$(cat $AUTOLOADFILE 2>/dev/null)"

    if [ -z "$FILECONTENT" ] ; then
        echo "File not found: $AUTOLOADFILE"
        exit 1
    fi

    FILECONTENT="${FILECONTENT//<path>/$SCRIPTFOLDER}"

    echo "$FILECONTENT" > $CFGAUTOLOADFILE
    echo "File created: $CFGAUTOLOADFILE"

elif [ "$1" == "off" ] ; then
    if [ -f "$CFGAUTOLOADFILE" ] ; then
        rm -f $CFGAUTOLOADFILE
        echo "File deleted: $CFGAUTOLOADFILE"
    fi
fi

exit 0

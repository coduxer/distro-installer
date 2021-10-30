#!/usr/bin/env bash

URL="$(curl -s https://api.github.com/repos/codehungers/wine-docker-builder/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}' | grep .deb)"
echo $URL
FILENAME=`basename $URL`
echo $FILENAME
TEMP='/tmp/downloads/wine-tkg'
mkdir -p "$TEMP"
FILEPATH="$TEMP/$FILENAME"
if [ ! -f $FILEPATH ]; then
    wget "$URL" -P "$TEMP"
fi

sudo apt install "$FILEPATH"
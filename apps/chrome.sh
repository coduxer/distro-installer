#!/usr/bin/env bash

ARCH=`dpkg --print-architecture`
TEMP='/tmp/downloads/chrome'
mkdir -p "$TEMP"
FILENAME='google-chrome-stable_current.deb'
FULLPATH="$TEMP/$FILENAME"
if [ ! -f "$FULLPATH" ]; then
    wget "https://dl.google.com/linux/direct/google-chrome-stable_current_$ARCH.deb" -O "$FULLPATH"
fi

sudo apt install "$FULLPATH"


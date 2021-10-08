#!/bin/bash
if ! [ -x "$(command -v 7z)" ]; then
    echo '7z is not installed, installing...' 
    sudo apt-get install p7zip-full
fi

VB_LATEST_VERSION=`curl -s http://download.virtualbox.org/virtualbox/LATEST.TXT`
TMP_DIR=`mktemp -d`
EXTRACT_DIR="$TMP_DIR/iso-output"
mkdir "$EXTRACT_DIR"

wget https://download.virtualbox.org/virtualbox/$VB_LATEST_VERSION/VBoxGuestAdditions_$VB_LATEST_VERSION.iso -P "$TMP_DIR"
7z x "$TMP_DIR/VBoxGuestAdditions_$VB_LATEST_VERSION.iso" -o$EXTRACT_DIR

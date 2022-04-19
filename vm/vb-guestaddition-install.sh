#!/bin/bash
#set -e
if ! [ -x "$(command -v 7z)" ]; then
    echo '7z is not installed, installing...' 
    sudo apt-get install p7zip-full
fi

if ! [ -x "$(command -v curl)" ]; then
    echo 'curl is not installed, installing...' 
    sudo apt-get install curl
fi

VB_LATEST_VERSION=`curl -s http://download.virtualbox.org/virtualbox/LATEST.TXT`
VB_ISO_FILE_NAME="VBoxGuestAdditions_$VB_LATEST_VERSION.iso"
TMP_DIR=`mktemp -d`
ISO_TMP_DIR='/tmp/VBoxGuestAdditions'
EXTRACT_DIR="$TMP_DIR/iso-output"
mkdir "$ISO_TMP_DIR" || echo hi
mkdir "$EXTRACT_DIR"

if [ ! -f "$ISO_TMP_DIR/$VB_ISO_FILE_NAME" ]; then
	wget https://download.virtualbox.org/virtualbox/$VB_LATEST_VERSION/VBoxGuestAdditions_$VB_LATEST_VERSION.iso -P "$ISO_TMP_DIR"
fi
7z x "$ISO_TMP_DIR/$VB_ISO_FILE_NAME" -o$EXTRACT_DIR
echo $EXTRACT_DIR
chmod +x $EXTRACT_DIR/autorun.sh
sed -i 's#/bin/read##g' "$EXTRACT_DIR/autorun.sh"
sed -i 's#read junk##g' "$EXTRACT_DIR/VBoxLinuxAdditions.run"
$EXTRACT_DIR/autorun.sh
sleep 2
PID=`pgrep -f "VirtualBox Guest Additions"`
#lsof -p $PID +r 1 &>/dev/null
tail --pid=$PID -f /dev/null

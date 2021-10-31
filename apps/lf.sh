#!/usr/bin/env bash

ARCH=`dpkg --print-architecture`
TEMP=`mktemp -d`
FULLPATH="$TEMP/lf.tar.gz"
URL="$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}' | grep "linux.*$ARCH")"
if [[ -z "${URL}" ]]; then
    echo "empty string"
    exit -1;
fi

if [ ! -f "${FULLPATH}" ]; then
    wget "$URL" -O "$FULLPATH"
fi
echo "$FULLPATH"
sudo tar xavf "$FULLPATH" -C '/usr/local/bin'


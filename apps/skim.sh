#!/usr/bin/env bash

TEMP=`mktemp -d`
FULLPATH="$TEMP/skim.tar.gz"
URL="$(curl -s https://api.github.com/repos/lotabout/skim/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}' | grep "`uname -m`.*unknown.*linux")"
if [[ -z "${URL}" ]]; then
    echo "empty string"
    exit -1;
fi

if [ ! -f "${FULLPATH}" ]; then
    wget "$URL" -O "$FULLPATH"
fi
echo "$FULLPATH"
sudo tar xavf "$FULLPATH" -C '/usr/local/bin'


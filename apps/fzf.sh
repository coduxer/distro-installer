#!/usr/bin/env bash

#!/usr/bin/env bash

TEMP=`mktemp -d`
FULLPATH="$TEMP/fzf.tar.gz"
ARCH=`dpkg --print-architecture`
URL="$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}' | grep "linux.*$ARCH")"
if [[ -z "${URL}" ]]; then
    echo "empty string"
    exit -1;
fi

if [ ! -f "${FULLPATH}" ]; then
    wget "$URL" -O "$FULLPATH"
fi
echo "$FULLPATH"
sudo tar xavf "$FULLPATH" -C '/usr/local/bin'


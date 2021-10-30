#!/usr/bin/env bash
ARCH=`dpkg-architecture -q DEB_BUILD_ARCH`
_dl_urls="$(curl -sL 'https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html' | grep -F "$ARCH.deb?__gda__" | grep -F "icaclient")"
URL=https:"$(echo "$_dl_urls" | sed -En 's|^.*rel="(//.*/[^"]*)".*$|\1|p')"
TEMP='/tmp/downloads/citrix'
mkdir -p "$TEMP"
FILENAME=`echo "$URL" | grep -Eo "icaclient_.*$ARCH.deb"`
FILEPATH="$TEMP/$FILENAME"
if [ ! -f $FILEPATH ]; then
    wget "$URL" -O "$TEMP/$FILENAME"
fi
sudo apt install "$TEMP/$FILENAME"
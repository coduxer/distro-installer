#!/usr/bin/env bash

if ! [ -x "$(command -v lsb_release)" ]; then
    echo '7z is not installed, installing...' 
    sudo apt-get install lsb-release
fi
KEYFILENAME=`mktemp -u --suffix ".key"`
CODENAME=$(. /etc/os-release; echo $UBUNTU_CODENAME)

sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key -O "$KEYFILENAME"
sudo apt-key add "$KEYFILENAME"
sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $CODENAME main"

sudo apt update
sudo apt install --install-recommends winehq-devel
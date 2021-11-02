#!/usr/bin/env bash

TEMP='/tmp/downloads/anydesk'
mkdir -p "$TEMP"
FILEPATH="$TEMP/anydesk.key"
KEYRINGPATH="$TEMP/anydesk-keyring.gpg"


wget "https://keys.anydesk.com/repos/DEB-GPG-KEY" -O "$FILEPATH"
gpg --no-default-keyring --keyring "$KEYRINGPATH" --import "$FILEPATH"
gpg --no-default-keyring --keyring "$KEYRINGPATH" --export | sudo tee "/usr/share/keyrings/anydesk-keyring.gpg"

echo "deb [signed-by=/usr/share/keyrings/anydesk-keyring.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

sudo apt update

sudo apt install anydesk
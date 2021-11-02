#!/usr/bin/env bash

sudo apt install libncursesw5-dev autotools-dev autoconf build-essential

TEMP='/tmp/downloads/htop-vim'

git clone "https://github.com/KoffeinFlummi/htop-vim" "$TEMP"

pushd "$TEMP"
    ./autogen.sh && ./configure --prefix="$PWD/install" && make install
    sudo cp "$PWD/install/bin/htop" "/usr/local/bin"
popd
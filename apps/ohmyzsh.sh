#!/usr/bin/env bash
if ! [ -x "$(command -v zsh)" ]; then
    echo '7z is not installed, installing...' 
    sudo apt-get install zsh
fi

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
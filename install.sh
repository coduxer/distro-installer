#!/usr/bin/env bash

config="$1"

if [ ! -f "$config" ]; then
    echo "config file don't exist: $config"
    exit -1
fi

source "$config"

if [[ "${VIRTUALMACHINE}" == "true" ]]; then
    ./vm/vb-guestaddition-install.sh
    ./vm/vtoyboot-deploy.sh
    ./vm/fix-grub-timeout.sh
fi


for app in "${APPS[@]}"; do
    "./apps/$app.sh"
done

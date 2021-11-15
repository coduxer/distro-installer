#!/usr/bin/env bash

config="$1"

if [ ! -f "$config" ]; then
    echo "config file don't exist: $config"
    exit -1
fi

source "$config"

for app in "${APPS[@]}"; do
    echo "${app}"
done

#!/usr/bin/env bash

TEMPDIR=$(mktemp -d)
chmod 777 "$TEMPDIR"
git clone https://mpr.hunterwittenborn.com/tap.git "$TEMPDIR"
pushd "$TEMPDIR"
makedeb -si

#!/usr/bin/env bash

sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/g' /etc/default/grub
sudo update-grub
#!/bin/bash
# Remove every installed version of the DKMS module and go back to the in-tree gpd-fan.
set -euo pipefail

for mv in $(dkms status gpd-fan-duo-fix | cut -d, -f1 | sort -u); do
    sudo dkms remove "$mv" --all
    sudo rm -rf "/usr/src/${mv/\//-}"
done
sudo modprobe -r gpd_fan
sudo modprobe gpd_fan
modinfo -n gpd_fan

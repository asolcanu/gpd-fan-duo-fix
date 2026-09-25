#!/bin/bash
# Install the patched gpd-fan module with DKMS (rebuilt for new kernels) and load it.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
ver=$(sed -n 's/^PACKAGE_VERSION="\(.*\)"/\1/p' dkms.conf)

# Remove other installed versions first
for mv in $(dkms status gpd-fan-duo-fix | cut -d, -f1 | sort -u); do
    [ "$mv" = "gpd-fan-duo-fix/$ver" ] && continue
    sudo dkms remove "$mv" --all
    sudo rm -rf "/usr/src/${mv/\//-}"
done

sudo install -Dm644 -t "/usr/src/gpd-fan-duo-fix-$ver" Makefile dkms.conf gpd-fan-duo-fix.patch
sudo install -Dm755 -t "/usr/src/gpd-fan-duo-fix-$ver" fetch-and-patch.sh
sudo dkms install "gpd-fan-duo-fix/$ver"
# Replace the loaded in-tree module
sudo modprobe -r gpd_fan
sudo modprobe gpd_fan
modinfo -n gpd_fan

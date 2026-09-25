#!/bin/bash
# DKMS PRE_BUILD: fetch gpd-fan.c for the kernel being built and apply the fix.
# $1 = kernel version (e.g. 7.2.3-1-cachyos-deckify)
set -euo pipefail

ver=${1%%-*}        # 7.2.3
ver=${ver%.0}       # stable tags drop a .0 patch level (v7.3, not v7.3.0)
url="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/hwmon/gpd-fan.c?h=v$ver"

curl -fsSL -o gpd-fan.c "$url"
if patch -p3 -R --dry-run -s < gpd-fan-duo-fix.patch >/dev/null 2>&1; then
    echo "gpd-fan-duo-fix: fix already in v$ver, building it unchanged"
else
    patch -p3 < gpd-fan-duo-fix.patch
fi

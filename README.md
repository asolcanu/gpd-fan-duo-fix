# gpd-fan-duo-fix

Fix for the in-kernel `gpd-fan` driver: on "duo" boards (GPD Duo, GPD Win 5
`G1618-05`) switching `pwm1_enable` to automatic only reset the first fan (EC
register `0x047A`). The second fan (`0x047B`) kept its last manual speed, e.g.
stuck at 100 % after `pwm1=255`.

DKMS fetches `gpd-fan.c` for each kernel from kernel.org, applies
`gpd-fan-duo-fix.patch` and installs the result over the in-tree module.

## Install

```
git clone https://github.com/asolcanu/gpd-fan-duo-fix.git
cd gpd-fan-duo-fix
./install.sh
```

Remove with `./uninstall.sh` once the fix is in the kernel.

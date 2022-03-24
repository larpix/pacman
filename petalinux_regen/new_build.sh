#! /bin/bash
rm -rf petalinux
petalinux-create -t project -n petalinux --template zynq
cp -f petalinux_rgen/config petalinux/project-spec/configs/config
cp -f petalinux_regen/system-user.dtsi
cp -f petalinux_regen/system-user.dtsi petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi
cp -f petalinux_regen/system-user.dtsi products/.
cd petalinux
petalinux-config --get-hw-description ../products/
petalinux-config #this time, configure for SD
petalinux-config -c kernel # can turn on drivers, in principle you can just close
petalinux-build
petalinux-package --boot --force ../petalinux_regen/boot.bif

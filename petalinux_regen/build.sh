#! /bin/bash
#cd petalinux
rm -rf petalinux
petalinux-create -t project -n petalinux --template zynq
cp -f petalinux_regen/config petalinux/project-spec/configs/config
cp -f petalinux_regen/system-user.dtsi petalinux/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi
cp -f petalinux_regen/system-user.dtsi products/.
cd petalinux
petalinux-config --get-hw-description ../products/
#petalinux-config
petalinux-config -c kernel
petalinux-build


# the TE customized version is no longer working for me... reverting to petalinux version for now
#petalinux-package --boot --force --bif boot.bif
#petalinux-package --boot --force --fsbl build/tmp/sysroots-components/plnx_zynq7/fsbl/boot/fsbl.elf --fpga images/linux/system.bit --u-boot
# if you want to append local files to rootfs, just add them to local/root:
#source local/update.sh

# bundle into tarball
#cd ../products
#filename=pacman-$(cat ../VERSION)-firmware
#mkdir $filename
#mv -fv ../petalinux/images/linux/BOOT.BIN ../petalinux/images/linux/image.ub ../petalinux/images/linux/rootfs-wlocal.tar.gz $filename
#tar cvzf $filename.tar.gz $filename && rm -rf $filename
#cd ..

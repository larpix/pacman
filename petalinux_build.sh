petalinux-create --type project --template zynq --name petalinux 
cd petalinux

petalinux-config --get-hw-description=../products/ 

petalinux-build


petalinux-config --get-hw-description=../products/ --defconfig ../petalinux_v2018.2/project-spec/configs/config 
Change DTC Settings --> (template)MACHINE_NAME to zc702

CONFIG_YOCTO_MACHINE_NAME =plnx-zynq7
CONFIG_YOCTO_MACHINE_NAME="zynq7z"


Change DTC Settings --> (template)MACHINE_NAME to zynq-generic
zynq-7000.dtsi

CONFIG_YOCTO_MACHINE_NAME="zynq-generic"



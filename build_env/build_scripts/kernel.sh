#!/bin/bash
. build_start $1 $0

make mrproper
#cp $DIST_ROOT/files/linux.config .config
make ARCH="arm" CROSS_COMPILE="${TARGET}-" bcmrpi_defconfig
#make ARCH="arm" CROSS_COMPILE="${TARGET}-" menuconfig
sed -i ".config" -e 's,^CONFIG_CROSS_COMPILE=.*,CONFIG_CROSS_COMPILE="'$TARGET'-",'

make -j$(nproc) ARCH="arm" CROSS_COMPILE="${TARGET}-" oldconfig
make -j$(nproc) ARCH="arm" CROSS_COMPILE="${TARGET}-" zImage dtbs modules

mkdir -pv $CLFS/sysroot/boot
cp arch/arm/boot/zImage "$CLFS/sysroot/boot/zImage"
cp -r arch/arm/boot/dts "$CLFS/sysroot/boot"

make ARCH="arm" CROSS_COMPILE="${TARGET}-" INSTALL_MOD_PATH="$CLFS/sysroot" modules_install

cd $DIST_ROOT/build_env
. build_end $1
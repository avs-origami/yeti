#!/bin/bash
. build_start $1 $0

cp ../linux.config .config

sed -i ".config" -e 's,^CONFIG_CROSS_COMPILE=.*,CONFIG_CROSS_COMPILE="'$CLFS_TARGET'-",'

make -j$(nproc) ARCH="$CLFS_ARCH" CROSS_COMPILE="${CLFS_TARGET}-" oldconfig
make -j$(nproc) ARCH="$CLFS_ARCH" CROSS_COMPILE="${CLFS_TARGET}-" zImage dtbs modules

mkdir -p "$CLFS/boot"
cp arch/arm/boot/zImage "$CLFS/boot"
cp -r arch/arm/boot/dts "$CLFS/boot"

make -j$(nproc) ARCH="$CLFS_ARCH" CROSS_COMPILE="${CLFS_TARGET}-" INSTALL_MOD_PATH="$CLFS" modules_install

cd $DIST_ROOT/build_env
. build_end $1

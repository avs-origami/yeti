#!/bin/bash
. build_start $1 $0

cp ../busybox.cfg .config

make CROSS_COMPILE="${CLFS_TARGET}-" oldconfig

sed -i ".config" -e 's,^CONFIG_CROSS_COMPILE=.*,CONFIG_CROSS_COMPILE="'$CLFS_TARGET'-",'
sed -i ".config" -e 's,^CONFIG_SYSROOT=.*,CONFIG_SYSROOT="'$CLFS'",'

make -j$(nproc) CROSS_COMPILE="${CLFS_TARGET}-"

mkdir $CLFS/bin
cp busybox "$CLFS/bin/bbstatic"

cd $DIST_ROOT/build_env
. build_end $1
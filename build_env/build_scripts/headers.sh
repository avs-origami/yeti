#!/bin/bash
. build_start $1 $0

make -j$(nproc) mrproper
make -j$(nproc) ARCH="$CLFS_ARCH" CROSS_COMPILE="${CLFS_TARGET}-" headers

cp -rv usr/include $CLFS/usr

cd $DIST_ROOT/build_env
. build_end $1
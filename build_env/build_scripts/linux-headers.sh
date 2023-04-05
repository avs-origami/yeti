#!/bin/bash
. build_start $1 $0

make mrproper
make ARCH=${CLFS_ARCH} headers
make ARCH=${CLFS_ARCH} INSTALL_HDR_PATH=${CLFS}/cross-tools/${CLFS_TARGET} headers_install

cd $DIST_ROOT/build_env
. build_end $1
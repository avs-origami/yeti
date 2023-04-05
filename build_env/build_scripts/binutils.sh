#!/bin/bash
. build_start $1 $0

mkdir -v build
cd build

../configure \
   --prefix=${CLFS}/cross-tools \
   --target=${CLFS_TARGET} \
   --with-sysroot=${CLFS}/cross-tools/${CLFS_TARGET} \
   --disable-nls \
   --disable-multilib

make configure-host
make

make install

cd $DIST_ROOT/build_env
. build_end $1
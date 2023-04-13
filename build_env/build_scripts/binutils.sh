#!/bin/bash
. build_start $1 $0

mkdir -v build
cd build

../configure \
   --prefix=${CLFS}/sysroot \
   --build=${CLFS_HOST} \
   --host=${TARGET} \
   --target=${TARGET} \
   --with-sysroot=${CLFS}/sysroot \
   --disable-nls \
   --disable-multilib \
   --enable-shared

make -j$(nproc)
make -j$(nproc) install

cd $DIST_ROOT/build_env
. build_end $1
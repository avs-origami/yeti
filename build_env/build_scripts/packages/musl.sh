#!/bin/bash
. build_start $1 $0

./configure \
  CROSS_COMPILE=${CLFS_TARGET}- \
  --prefix=/ \
  --disable-static \
  --target=${CLFS_TARGET}

make -j$(nproc) 
DESTDIR=${CLFS}/targetfs make -j$(nproc) install-libs

cd $DIST_ROOT/build_env
. build_end $1
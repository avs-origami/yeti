#!/bin/bash
. build_start $1 $0

./configure \
  CROSS_COMPILE=${TARGET}- \
  --prefix=/ \
  --disable-static \
  --target=${TARGET}

make -j$(nproc)
DESTDIR=$CLFS/sysroot make -j$(nproc) install

cd $DIST_ROOT/build_env
. build_end $1
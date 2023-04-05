#!/bin/bash
. build_start $1 $0

./configure \
  CROSS_COMPILE=${CLFS_TARGET}- \
  --prefix=/ \
  --target=${CLFS_TARGET}

make
make DESTDIR=${CLFS}/cross-tools/${CLFS_TARGET} install

cd $DIST_ROOT/build_env
. build_end $1
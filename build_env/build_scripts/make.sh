#!/bin/bash
. build_start $1 $0

./configure --prefix=$CLFS/sysroot/ \
    --build=${CLFS_HOST} --host=${TARGET}

make -j$(nproc)
make -j$(nproc) install

cd $DIST_ROOT/build_env
. build_end $1
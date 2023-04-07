#!/bin/bash
. build_start $1 $0

./configure --prefix="$CLFS/tools" --target="$CLFS_TARGET" \
    --with-sysroot="$CLFS" \
    --disable-nls \
    --disable-multilib

make -j$(nproc) configure-host
make -j$(nproc) 
make -j$(nproc) install

cd $DIST_ROOT/build_env
. build_end $1
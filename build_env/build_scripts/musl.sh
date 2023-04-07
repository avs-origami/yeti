#!/bin/bash
. build_start $1 $0

CC="${CLFS_TARGET}-gcc" ./configure --prefix=/ --includedir=/usr/include \
                                    --target="$CLFS_TARGET"

CC="${CLFS_TARGET}-gcc" make -j$(nproc)
make -j$(nproc) DESTDIR="$CLFS" install

cd $DIST_ROOT/build_env
. build_end $1
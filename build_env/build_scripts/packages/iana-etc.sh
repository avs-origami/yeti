#!/bin/bash
. build_start $1 $0

patch -Np1 -i ../iana-etc-2.30-update-2.patch

make -j$(nproc) get
make -j$(nproc) STRIP=yes
make -j$(nproc) DESTDIR=${CLFS}/targetfs install

cd $DIST_ROOT/build_env
. build_end $1
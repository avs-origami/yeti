#!/bin/bash
. build_start $1 $0

mkdir -v build
cd build

../configure --prefix="$CLFS/tools" --target="$CLFS_TARGET" --build="x86_64-linux-gnu" \
                --host="x86_64-linux-gnu" --with-sysroot="$CLFS" \
                --disable-nls --enable-languages=c,c++ \
                --enable-c99 --enable-long-long \
                --disable-libmudflap --disable-multilib \
                --disable-libsanitizer --with-arch="$CLFS_ARM_ARCH" \
                --with-native-system-header-dir="/usr/include" \
                --with-float=hard --with-fpu=neon-vfpv3

make -j$(nproc)
make -j$(nproc) install

cd $DIST_ROOT/build_env
. build_end $1
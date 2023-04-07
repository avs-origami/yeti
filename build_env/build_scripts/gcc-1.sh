#!/bin/bash
. build_start $1 $0

mkdir -v build
cd build

../configure --prefix="$CLFS/tools" --target="$CLFS_TARGET" --build="x86_64-linux-gnu" \
                --host="x86_64-linux-gnu" --with-sysroot="$CLFS" \
                --disable-nls --disable-shared --without-headers \
                --disable-multilib --disable-decimal-float \
                --disable-libgomp --disable-libmudflap \
                --disable-libssp --disable-libatomic \
                --disable-libquadmath --disable-threads \
                --enable-languages=c --with-newlib \
                --with-arch="$CLFS_ARM_ARCH" --with-float=hard \
                --with-fpu=neon-vfpv3

make -j$(nproc) all-gcc all-target-libgcc
make -j$(nproc) install-gcc install-target-libgcc

cd $DIST_ROOT/build_env
. build_end $1
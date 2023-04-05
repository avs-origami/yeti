#!/bin/bash
. build_start $1 $0

tar xf ../mpfr-4.2.0.tar.bz2
mv -v mpfr-4.2.0 mpfr
tar xf ../gmp-6.2.1.tar.bz2
mv -v gmp-6.2.1 gmp
tar xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

mkdir -v build
cd build

../configure \
  --prefix=${CLFS}/cross-tools \
  --build=${CLFS_HOST} \
  --host=${CLFS_HOST} \
  --target=${CLFS_TARGET} \
  --with-sysroot=${CLFS}/cross-tools/${CLFS_TARGET} \
  --disable-nls \
  --disable-shared \
  --without-headers \
  --with-newlib \
  --disable-decimal-float \
  --disable-libgomp \
  --disable-libmudflap \
  --disable-libssp \
  --disable-libatomic \
  --disable-libquadmath \
  --disable-threads \
  --enable-languages=c \
  --disable-multilib \
  --with-mpfr-include=$(pwd)/../gcc-6.2.0/mpfr/src \
  --with-mpfr-lib=$(pwd)/mpfr/src/.libs \
  --with-arch=${CLFS_ARM_ARCH} \
  --with-float=${CLFS_FLOAT} \
  --with-fpu=${CLFS_FPU}

make all-gcc all-target-libgcc
make install-gcc install-target-libgcc

cd $DIST_ROOT/build_env
. build_end $1
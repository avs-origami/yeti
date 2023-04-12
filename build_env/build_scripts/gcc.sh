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

# export CC=\""${TARGET}-gcc --sysroot=${CLFS}/sysroot\""
# export CXX=\""${TARGET}-g++ --sysroot=${CLFS}/sysroot\""
# export AR=\""{TARGET}-ar\""
# export AS=\""${TARGET}-as\""
# export LD=\""${TARGET}-ld --sysroot=${CLFS}/sysroot\""
# export RANLIB=\""${TARGET}-ranlib\""
# export READELF=\""${TARGET}-readelf\""

../configure \
  --prefix=${CLFS}/sysroot \
  --build=${CLFS_HOST} \
  --host=${TARGET} \
  --target=${TARGET} \
  --with-sysroot=${CLFS}/sysroot \
  --disable-nls \
  --enable-languages=c,c++ \
  --enable-c99 \
  --enable-long-long \
  --disable-libmudflap \
  --disable-multilib \
  --disable-libsanitizer \
  --with-mpfr-include=$(pwd)/../mpfr/src \
  --with-mpfr-lib=$(pwd)/mpfr/src/.libs \
  --with-arch=${CLFS_ARM_ARCH} \
  --with-float=${CLFS_FLOAT} \
  --with-fpu=${CLFS_FPU}

make
make install

cd $DIST_ROOT/build_env
. build_end $1
#!/bin/bash
. build_start $1 $0

make distclean
make ARCH="${ARCH}" defconfig

sed -i 's/\(CONFIG_\)\(.*\)\(INETD\)\(.*\)=y/# \1\2\3\4 is not set/g' .config
sed -i 's/\(CONFIG_IFPLUGD\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_FEATURE_WTMP\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_FEATURE_UTMP\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_UDPSVD\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_TCPSVD\)=y/# \1 is not set/' .config

make ARCH="${ARCH}" CROSS_COMPILE="${TARGET}-"
make ARCH="${ARCH}" CROSS_COMPILE="${TARGET}-"\
  CONFIG_PREFIX="${CLFS}/sysroot" install

cp -v examples/depmod.pl ${CLFS}/toolchain/bin
chmod -v 755 ${CLFS}/toolchain/bin/depmod.pl

cd $DIST_ROOT/build_env
. build_end $1
#!/bin/bash
. build_start $1 $0

make -j$(nproc) distclean
make -j$(nproc) ARCH="${CLFS_ARCH}" defconfig

sed -i 's/\(CONFIG_\)\(.*\)\(INETD\)\(.*\)=y/# \1\2\3\4 is not set/g' .config
sed -i 's/\(CONFIG_IFPLUGD\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_FEATURE_WTMP\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_FEATURE_UTMP\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_UDPSVD\)=y/# \1 is not set/' .config
sed -i 's/\(CONFIG_TCPSVD\)=y/# \1 is not set/' .config

make -j$(nproc) ARCH="${CLFS_ARCH}" CROSS_COMPILE="${CLFS_TARGET}-"
make -j$(nproc) ARCH="${CLFS_ARCH}" CROSS_COMPILE="${CLFS_TARGET}-"\
  CONFIG_PREFIX="${CLFS}/targetfs" install

cp -v examples/depmod.pl ${CLFS}/cross-tools/bin
chmod -v 755 ${CLFS}/cross-tools/bin/depmod.pl

cd $DIST_ROOT/build_env
. build_end $1
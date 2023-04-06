#!/bin/bash
export CC=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-gcc --sysroot=${CLFS}/targetfs\""
export CXX=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-g++ --sysroot=${CLFS}/targetfs\""
export AR=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-ar\""
export AS=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-as\""
export LD=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-ld --sysroot=${CLFS}/targetfs\""
export RANLIB=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-ranlib\""
export READELF=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-readelf\""
export STRIP=\""${CLFS}/targetfs/bin/${CLFS_TARGET}-strip\""

#bash -e build_scripts/packages/libgcc.sh
bash -e build_scripts/packages/musl.sh musl-1.2.3.tar.gz
#bash -e build_scripts/packages/busybox.sh busybox-1.36.0.tar.bz2
#bash -e build_scripts/packages/iana-etc.sh iana-etc-2.30.tar.bz2
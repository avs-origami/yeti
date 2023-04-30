#!/bin/bash

echo "The 'DIST_ROOT', 'CLFS', 'CLFS_TARGET', and 'LFS_HN' variables must be set for this script to run."
echo "It is recommended to set them in your shell's RC file. See README for more information."
echo

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "CLFS: ${CLFS:?}"
echo "CLFS_TARGET: ${CLFS_TARGET:?}"
echo "LFS_HN: ${LFS_HN:?}"
echo

sleep 1

# Set variables needed for proper execution
set +h
PATH=$CLFS/toolchain/bin/:$PATH
CONFIG_SITE=$CLFS/usr/share/config.site
LC_ALL=POSIX
SHELL=bash
export PATH CONFIG_SITE LC_ALL

### Setup
#########

export MUSSEL_ARCH=armv6zk
export TARGET=$MUSSEL_ARCH-linux-musleabihf
echo "Creating build environment..."
cd $DIST_ROOT/build_env/build_root

### Cross compiler (mussel)
###########################

bash -e sources/check.sh &&
bash -e sources/mussel.sh $MUSSEL_ARCH --enable-linux-headers --enable-pkg-config --parallel

### Packages
############

cd $DIST_ROOT/build_env

bash -e build_scripts/musl.sh musl-1.2.3.tar.gz
bash -e build_scripts/binutils.sh binutils-2.40.tar.bz2
bash -e build_scripts/gcc.sh gcc-12.2.0.tar.xz
bash -e build_scripts/busybox.sh busybox-1.36.0.tar.bz2
bash -e build_scripts/kernel.sh linux-1.20230317.tar.gz
bash -e build_scripts/bootscripts.sh bootscripts-embedded-master.tar.gz
bash -e build_scripts/ypm.sh ypm-0.0.2-alpha.tar.gz
bash -e build_scripts/make.sh make-4.4.tar.gz
bash -e build_scripts/wpa_supplicant.sh wpa_supplicant-2.10.tar.gz

### Setup files
###############

bash -e build_scripts/files/mdev.sh
bash -e build_scripts/files/profile.sh
bash -e build_scripts/files/inittab.sh
bash -e build_scripts/files/network.sh
bash -e build_scripts/files/filesystem.sh
bash -e build_scripts/files/yeti-os.sh

echo "$LFS_HN" > ${CLFS}/sysroot/etc/hostname

### Finishing touches
#####################

#cp $DIST_ROOT/files/yetifetch $CLFS/sysroot/bin/yetifetch

# Uncomment to change ownership of entire sysroot to root. This MUST be done
# before booting, but could also be done once files are copied to SD card, etc.
# chown -R root:root ${CLFS}/sysroot
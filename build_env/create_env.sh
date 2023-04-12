#!/bin/bash

echo "The 'DIST_ROOT', 'CLFS', 'CLFS_TARGET', and 'LFS_HN' variables must be set for this script to run."
echo "It is recommended to set them in your shell's RC file. See README for more information."

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "CLFS: ${CLFS:?}"
echo "CLFS_TARGET: ${CLFS_TARGET:?}"
echo "LFS_HN: ${LFS_HN:?}"

sleep 1

# Set variables needed for proper execution
set +h
PATH=${CLFS}/tools/bin/:$PATH
CONFIG_SITE=$CLFS/usr/share/config.site
LC_ALL=POSIX
SHELL=bash
export PATH CONFIG_SITE LC_ALL

### Needed Variables
####################

export ARCH=armv6zk

echo "Creating build environment..."
cd $DIST_ROOT/build_env/build_root

#bash -e sources/check.sh &&
#bash -e sources/mussel.sh $ARCH --enable-linux-headers --enable-pkg-config --parallel

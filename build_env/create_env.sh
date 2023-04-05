#!/bin/bash

echo "The 'DIST_ROOT', 'LFS', 'LFS_TGT', and 'LFS_HN' variables must be set for this script to run."
echo "It is recommended to set them in your shell's RC file. See README for more information."

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"
echo "LFS_TGT: ${LFS_TGT:?}"
echo "LFS_HN: ${LFS_HN:?}"

sleep 1

# Set variables needed for proper execution
set +h
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
LC_ALL=POSIX
SHELL=bash
export PATH CONFIG_SITE LC_ALL

echo "Creating build environment..."
cd $DIST_ROOT/build_env/

#bash -e build_scripts/linux-headers.sh linux-6.1.11.tar.xz
#bash -e build_scripts/binutils.sh binutils-2.40.tar.bz2
#bash -e build_scripts/gcc.sh gcc-12.2.0.tar.xz
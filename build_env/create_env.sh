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

############# CROSS COMPILER #############
#bash -e build_scripts/packages/binutils-pass-1.sh
#bash -e build_scripts/packages/gcc-pass-1.sh
#bash -e build_scripts/packages/linux-headers.sh
#bash -e build_scripts/packages/glibc.sh
#bash -e build_scripts/packages/libstdcpp-pass-1.sh
##########################################

################# TEMPORARY TOOLS #################
#bash -e build_scripts/packages/m4.sh m4-1.4.19.tar.xz
#bash -e build_scripts/packages/ncurses.sh ncurses-6.3.tar.gz
#bash -e build_scripts/packages/bash.sh bash-5.1.16.tar.gz
#bash -e build_scripts/packages/coreutils.sh coreutils-9.1.tar.xz
#bash -e build_scripts/packages/diffutils.sh diffutils-3.8.tar.xz
#bash -e build_scripts/packages/file.sh file-5.42.tar.gz
#bash -e build_scripts/packages/findutils.sh findutils-4.9.0.tar.xz
#bash -e build_scripts/packages/gawk.sh gawk-5.1.1.tar.xz
#bash -e build_scripts/packages/grep.sh grep-3.7.tar.xz
#bash -e build_scripts/packages/gzip.sh gzip-1.12.tar.xz
#bash -e build_scripts/packages/make.sh make-4.3.tar.gz
#bash -e build_scripts/packages/patch.sh patch-2.7.6.tar.xz
#bash -e build_scripts/packages/sed.sh sed-4.8.tar.xz
#bash -e build_scripts/packages/tar.sh tar-1.34.tar.xz
#bash -e build_scripts/packages/xz.sh xz-5.2.6.tar.xz
#bash -e build_scripts/packages/binutils-pass-2.sh binutils-2.39.tar.xz
#bash -e build_scripts/packages/gcc-pass-2.sh gcc-12.2.0.tar.xz
###################################################

echo "Temporary packages built. Entering chroot."

sudo -E build_scripts/build_chroot.sh

echo "System build complete."

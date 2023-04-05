#!/bin/bash
echo "The 'DIST_ROOT' and 'LFS' variables must be set for this script to run. It is recommended to set them in your shell's RC file."

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

unset CFLAGS
export CLFS_FLOAT="soft"
export CLFS_HOST=$(echo ${MACHTYPE} | sed "s/-[^-]*/-cross/")
export CLFS_TARGET="arm-linux-musleabi"
export CLFS_ARCH=arm
export CLFS_ARM_ARCH="armv6"

mkdir -p ${CLFS}/cross-tools/${CLFS_TARGET}
ln -sfv . ${CLFS}/cross-tools/${CLFS_TARGET}/usr

mkdir -p $CLFS/sources

for f in $(cat $DIST_ROOT/build_env/sources.txt)
do
    bn=$(basename $f)
    bnp=".$bn.part"

    if ! test -f $LFS/sources/$bn
    then
        touch $LFS/sources/$bnp
        wget $f -O $LFS/sources/$bn
        rm $LFS/sources/$bnp
    elif test -f $LFS/sources/$bnp
    then
        wget $f -O $LFS/sources/$bn
        rm $LFS/sources/$bnp
    fi
done
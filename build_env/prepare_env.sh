#!/bin/bash
echo "The 'DIST_ROOT', 'CLFS', 'CLFS_TARGET', and 'LFS_HN' variables must be set for this script to run."
echo "It is recommended to set them in your shell's RC file. See README for more information."

echo "DIST_ROOT: ${DIST_ROOT:?}"
echo "CLFS: ${CLFS:?}"
echo "CLFS_TARGET: ${CLFS_TARGET:?}"
echo "LFS_HN: ${LFS_HN:?}"

unset CFLAGS
export CLFS_FLOAT="soft"
export CLFS_HOST=$(echo ${MACHTYPE} | sed "s/-[^-]*/-cross/")
export CLFS_TARGET="arm-linux-musleabi"
export CLFS_ARCH=arm
export CLFS_ARM_ARCH="armv6"

mkdir -p $CLFS/sources

for f in $(cat $DIST_ROOT/build_env/sources.txt)
do
    bn=$(basename $f)
    bnp=".$bn.part"

    if ! test -f $CLFS/sources/$bn
    then
        touch $CLFS/sources/$bnp
        wget $f -O $CLFS/sources/$bn
        rm $CLFS/sources/$bnp
    elif test -f $CLFS/sources/$bnp
    then
        wget $f -O $CLFS/sources/$bn
        rm $CLFS/sources/$bnp
    fi
done

cp files/{busybox.config, linux.config} build_env/build_root/sources/
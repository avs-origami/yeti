#!/bin/bash
. build_start $1 $0

RUSTFLAGS="-C linker=$CLFS/toolchain/bin/$TARGET-gcc" cargo build --release --target=arm-unknown-linux-musleabihf

cp target/arm-unknown-linux-musleabihf/release/ypm $CLFS/sysroot/bin/ypm
cp -r repo $CLFS/sysroot/etc/ypm/
mkdir -pv $CLFS/sysroot/share/man/man8
cp man/ypm.8 $CLFS/sysroot/share/man/man8/
cp helpfile.txt $CLFS/sysroot/etc/ypm/

cd $DIST_ROOT/build_env
. build_end $1
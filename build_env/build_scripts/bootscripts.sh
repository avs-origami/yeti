#!/bin/bash
. build_start $1 $0

make DESTDIR=${CLFS}/sysroot install-bootscripts

cd $DIST_ROOT/build_env
. build_end $1
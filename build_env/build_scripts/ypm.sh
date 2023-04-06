#!/bin/bash
cd $CLFS/sources/ypm

cargo build

cp target/debug/ypm $CLFS/targetfs/bin/ypm
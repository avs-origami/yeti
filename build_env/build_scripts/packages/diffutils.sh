. build_start $1 $0

./configure --prefix=/usr --host=$LFS_TGT

make
make DESTDIR=$LFS install

cd $DIST_ROOT/build_env
. build_end $1
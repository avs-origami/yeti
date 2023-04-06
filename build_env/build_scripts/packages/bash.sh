. build_start $1 $0

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc

make
make DESTDIR=$LFS install

ln -sv bash $LFS/bin/sh

cd $DIST_ROOT/build_env
. build_end $1
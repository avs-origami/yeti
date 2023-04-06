. /dist/build_env/build_start $1 $0

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make && make install

. /dist/build_env/build_end $1
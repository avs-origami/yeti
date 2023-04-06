. /dist/build_env/build_start $1 $0

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make && make install

. /dist/build_env/build_end $1
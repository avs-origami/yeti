. /dist/build_env/build_start $1 $0

./configure --disable-shared

make

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

. /dist/build_env/build_end $1
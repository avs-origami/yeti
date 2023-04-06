. /dist/build_env/build_start $1 $0

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --enable-utf8     \
            --docdir=/usr/share/doc/nano-6.4 &&

make

make install &&
install -v -m644 doc/{nano.html,sample.nanorc} /usr/share/doc/nano-6.4

cat > /etc/nanorc << "EOF"
set autoindent
set constantshow
set fill 72
set historylog
set multibuffer
set positionlog
set quickblank
set regexp

## Colors
set titlecolor bold,black,blue
set promptcolor black,cyan
set statuscolor bold,black,green
set errorcolor bold,black,red
set spotlightcolor black,lightyellow
set selectedcolor lightwhite,magenta
set stripecolor ,yellow
set scrollercolor cyan
set numbercolor cyan
set keycolor cyan
set functioncolor green
EOF

. /dist/build_env/build_end $1
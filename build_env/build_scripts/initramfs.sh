#!/bin/bash
. build_start $1 $0

gcc "usr/gen_init_cpio.c" -o gen_init_cpio

mkdir -pv ../initramfs
cp gen_init_cpio ../initramfs
cd ../initramfs

cat > initramfs.files <<_EOF
dir boot 0755 0 0
dir dev 0755 0 0
dir lib 0755 0 0
dir bin 0755 0 0
dir sys 0755 0 0
dir proc 0755 0 0
dir newroot 0755 0 0
slink sbin bin 0777 0 0
nod dev/console 0600 0 0 c 5 1
file bin/busybox $CLFS/bin/bbstatic 0755 0 0
slink bin/sh /bin/busybox 0777 0 0
file init $CLFS/sources/initramfs/init 0755 0 0
_EOF

cat > init <<_EOF
#!/bin/sh

PATH=/bin

/bin/busybox --install
/bin/busybox mount -t proc none /proc
/bin/busybox mount -t sysfs none /sys
/bin/busybox mount -t devtmpfs none /dev

cat <<!


Boot took 937.7 seconds


__  __       __    _        ____    ____
 \ \/ / ___  / /_  (_)      / __ \  / __/
  \  / / -_)/ __/ / /      / /_/ / _\ \  
  /_/  \__/ \__/ /_/       \____/ /___/


Welcome to Yeti OS - initramfs


!


exec /bin/busybox sh
_EOF

sed -i 's/937.7/$(cut -d' ' -f1 /proc/uptime)/g' init

./gen_init_cpio initramfs.files | xz --check=crc32 > initramfs.xz
cp initramfs.xz "$CLFS/boot"

cd $DIST_ROOT/build_env
. build_end $1
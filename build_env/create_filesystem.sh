#!/bin/bash
mkdir -pv ${CLFS}/targetfs/{bin,boot,dev,etc,home,lib/{firmware,modules}}
mkdir -pv ${CLFS}/targetfs/{mnt,opt,proc,sbin,srv,sys}
mkdir -pv ${CLFS}/targetfs/var/{cache,lib,local,lock,log,opt,run,spool}
install -dv -m 0750 ${CLFS}/targetfs/root
install -dv -m 1777 ${CLFS}/targetfs/{var/,}tmp
mkdir -pv ${CLFS}/targetfs/usr/{,local/}{bin,include,lib,sbin,share,src}

ln -svf ${CLFS}/targetfs/proc/mounts ${CLFS}/targetfs/etc/mtab
ln -sfv ${CLFS}/targetfs/run ${CLFS}/targetfs/var/run
ln -sfv ${CLFS}/targetfs/run/lock ${CLFS}/targetfs/var/lock

cat > ${CLFS}/targetfs/etc/passwd << "EOF"
root::0:0:root:/root:/bin/ash
EOF

cat > ${CLFS}/targetfs/etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tty:x:4:
tape:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
EOF

touch ${CLFS}/targetfs/var/log/lastlog
chmod -v 664 ${CLFS}/targetfs/var/log/lastlog
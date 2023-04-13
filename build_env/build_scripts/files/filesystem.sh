mkdir -pv ${CLFS}/sysroot/{bin,boot,dev,etc,home,lib/{firmware,modules}}
mkdir -pv ${CLFS}/sysroot/{mnt,opt,proc,sbin,srv,sys}
mkdir -pv ${CLFS}/sysroot/var/{cache,lib,local,lock,log,opt,run,spool}
install -dv -m 0750 ${CLFS}/sysroot/root
install -dv -m 1777 ${CLFS}/sysroot/{var/,}tmp

ln -svf ${CLFS}/sysroot/proc/mounts ${CLFS}/sysroot/etc/mtab
cat > ${CLFS}/sysroot/etc/passwd << "EOF"
root::0:0:root:/root:/bin/ash
EOF

cat > ${CLFS}/sysroot/etc/group << "EOF"
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

touch ${CLFS}/sysroot/var/log/lastlog
chmod -v 664 ${CLFS}/sysroot/var/log/lastlog
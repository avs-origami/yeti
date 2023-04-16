echo -n "Creating filesystem... "

mkdir -pv ${CLFS}/sysroot/{bin,boot,dev,etc,home,lib/{firmware,modules}}
mkdir -pv ${CLFS}/sysroot/{mnt,opt,proc,sys,tmp}
mkdir -pv ${CLFS}/sysroot/var/{cache,lib,local,lock,log,opt,run,spool}
mkdir -pv ${CLFS}/sysroot/etc/ypm/{pkg/{musl,binutils,gcc,busybox,kernel,ypm},cache}
install -dv -m 0750 ${CLFS}/sysroot/root
install -dv -m 1777 ${CLFS}/sysroot/var/tmp

cd $CLFS/sysroot
ln -svf bin sbin
ln -svf . usr
cd $DIST_ROOT/build_env

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

cat > ${CLFS}/sysroot/etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options                     dump  fsck
#                                                                      order

/dev/mmcblk0p1 /boot        vfat     defaults                    0     1
/dev/mmcblk0p2 /            ext4     defaults,noatime,nodiratime 0     2
#/swapfile     swap         swap     pri=1                       0     0
proc           /proc        proc     nosuid,noexec,nodev         0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev         0     0
devpts         /dev/pts     devpts   gid=5,mode=620              0     0
tmpfs          /run         tmpfs    defaults                    0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid            0     0
tmpfs          /dev/shm     tmpfs    nosuid,nodev                0     0

# End /etc/fstab
EOF

echo "done"
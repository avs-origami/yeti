echo -n "Applying Yeti OS specific customizations... "

cat > $CLFS/sysroot/etc/os-release << "EOF"
NAME="Yeti OS"
VERSION="0.1.1"
ID=yeti
PRETTY_NAME="Yeti OS"
VERSION_CODENAME="sodium"
EOF

cat > $CLFS/sysroot/etc/lsb-release << "EOF"
DISTRIB_ID="Yeti OS"
DISTRIB_RELEASE="0.1.1"
DISTRIB_CODENAME="sodium"
DISTRIB_DESCRIPTION="Bit-sized linux"
EOF

cat > $CLFS/sysroot/etc/issue << "EOF"
Yeti OS 0.1.1
EOF

cat > $CLFS/sysroot/etc/rc.d/startup << "EOF"
#!/bin/ash

# System Startup Script
# 
. /etc/rc.d/init.d/functions

/bin/mount -t proc none /proc
/bin/mount -t sysfs none /sys
/bin/mount -t tmpfs /tmp /tmp
/bin/mkdir /dev/pts
/bin/mkdir /dev/shm

/bin/echo "/sbin/mdev" > /proc/sys/kernel/hotplug

echo -n "Starting mdev: "
/sbin/mdev -s
check_status

echo -n "Mounting devpts: "
/bin/mount -t devpts none /dev/pts
check_status

echo -n "Mounting shared memory: "
/bin/mount -t tmpfs none /dev/shm
check_status

if [ -x /sbin/hwclock ] && [ -e /dev/rtc0 ]; then
	echo -n "Setting system clock: "
	hwclock --hctosys --utc
	check_status
fi

if [ -x /sbin/fsck ]; then
	echo "Starting fsck for local filesystems."
	fsck -A -C -R -T -t nonfs,nosmbfs
	if [ "$?" -gt 2 ]; then
		echo "WARNING: Errors found while checking filesystems."
		echo "You can login as root now, the system will reboot after logout."
		sulogin
		reboot
	elif [ "$?" = "2" ]; then
		echo "NOTICE: System needs to be rebooted now."
		sleep 1
		reboot
	else
		echo -n "Checking local filesystems: "
		check_status
	fi
fi


if [ -x /sbin/swapon ]; then
	echo -n "Enabling swap space: "
	swapon -a
	check_status
fi

echo -n "Remounting root rw: "
mount -o remount,rw /
check_status

echo -n "Linking /var/tmp and /tmp: "
ln -s ../tmp /var/tmp
check_status

echo -n "Setting hostname: "
hostname -F /etc/hostname
check_status

echo -n "Cleaning up system: "
rm -rf /var/run/*
> /var/run/utmp
touch /var/log/wtmp
touch /var/log/messages
chmod 0664 /var/run/utmp
chmod 0664 /var/log/wtmp
chmod 0660 /var/log/messages
rm -rf /tmp/*
check_status

echo -n "Setting up interface lo: "
ifconfig lo up 127.0.0.1
check_status

echo "Running start scripts."

for i in /etc/rc.d/start/*
do
	if [ -x $i ]; then
		$i start
	fi
done

cat <<!

Boot took $(cut -d' ' -f1 /proc/uptime) seconds

 __  __       __    _        ____    ____
 \ \/ / ___  / /_  (_)      / __ \  / __/
  \  / / -_)/ __/ / /      / /_/ / _\ \  
  /_/  \__/ \__/ /_/       \____/ /___/

!

exit 0
EOF

echo "done"
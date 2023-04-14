echo -n "Configuring network files... "

mkdir -pv ${CLFS}/sysroot/etc/network/if-{post-{up,down},pre-{up,down},up,down}.d
mkdir -pv ${CLFS}/sysroot/usr/share/udhcpc

cat > ${CLFS}/sysroot/etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost
192.168.1.73 yeti-os.example.org yeti-os

# End /etc/hosts (network card version)
EOF

cat > $CLFS/sysroot/etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

domain yeti-os.example.org
nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

cat > ${CLFS}/sysroot/etc/network/interfaces << "EOF"
auto eth0
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet dhcp
        wpa-driver nl80211
        wpa-conf /etc/wpa_supplicant.conf
EOF

cat > ${CLFS}/sysroot/usr/share/udhcpc/default.script << "EOF"
#!/bin/sh
# udhcpc Interface Configuration
# Based on http://lists.debian.org/debian-boot/2002/11/msg00500.html
# udhcpc script edited by Tim Riker <Tim@Rikers.org>

[ -z "$1" ] && echo "Error: should be called from udhcpc" && exit 1

RESOLV_CONF="/etc/resolv.conf"
[ -n "$broadcast" ] && BROADCAST="broadcast $broadcast"
[ -n "$subnet" ] && NETMASK="netmask $subnet"

case "$1" in
        deconfig)
                /sbin/ifconfig $interface 0.0.0.0
                ;;

        renew|bound)
                /sbin/ifconfig $interface $ip $BROADCAST $NETMASK

                if [ -n "$router" ] ; then
                        while route del default gw 0.0.0.0 dev $interface ; do
                                true
                        done

                        for i in $router ; do
                                route add default gw $i dev $interface
                        done
                fi

                echo -n > $RESOLV_CONF
                [ -n "$domain" ] && echo search $domain >> $RESOLV_CONF
                for i in $dns ; do
                        echo nameserver $i >> $RESOLV_CONF
                done
                ;;
esac

exit 0
EOF

chmod +x ${CLFS}/sysroot/usr/share/udhcpc/default.script

echo "done"
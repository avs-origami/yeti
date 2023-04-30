#!/bin/bash
. build_start $1 $0

cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_SMARTCARD=n
CONFIG_WPS=y
CONFIG_TLS=internal
CONFIG_INTERNAL_LIBTOMMATH=y
CONFIG_INTERNAL_LIBTOMMATH_FAST=y
EOF

cd wpa_supplicant &&
make -j$(nproc) CC="${TARGET}-gcc"

mkdir -pv $CLFS/sysroot/usr/share/man/man5/
install -v -m755 wpa_{cli,passphrase,supplicant} $CLFS/sysroot/bin/ &&
install -v -m644 doc/docbook/wpa_supplicant.conf.5 $CLFS/sysroot/usr/share/man/man5/ &&
install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 $CLFS/sysroot/usr/share/man/man8/

cd $DIST_ROOT/build_env
. build_end $1
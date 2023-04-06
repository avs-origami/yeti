set -e

echo "Preparing ${LFS:?}"

chown -R root:root $LFS/{usr,lib,lib64,var,etc,bin,sbin,tools}
mkdir -pv $LFS/{dev,proc,sys,run}

cp $LFS/usr/lib/ld-linux-x86-64.so.2 $LFS/lib/ld-linux-x86-64.so.2
cp $LFS/usr/bin/bash $LFS/bin/bash

cat > $LFS/etc/hosts << EOF
127.0.0.1  localhost $LFS_HN
::1        localhost
EOF

bash -e $DIST_ROOT/build_env/build_scripts/mnt_vfs.sh

chroot "$LFS" /usr/bin/env -i      \
    HOME=/root                     \
    TERM="$TERM"                   \
    PS1='(\u@yocto_chroot) \w \$ ' \
    PATH=/usr/bin:/usr/sbin:/bin   \
    DIST_ROOT=/dist                \
    /dist/build_env/build_scripts/finish_build.sh

bash -e $DIST_ROOT/build_env/build_scripts/umnt_vfs.sh

echo "Continue? (y/N) "
read yn

case $yn in
    [Yy]* ) 
        echo "Backing up current root filesystem to $DIST_ROOT/backup/yocto-temp-tools-$(date +'%m%d%y').tar.xz."
        cd $LFS
        mkdir -pv $DIST_ROOT/backup
        tar -cJpf $DIST_ROOT/backup/yocto-temp-tools-$(date +'%m%d%y').tar.xz .

        echo "Cleaning up."
        rm -rf $LFS/usr/share/{info,man,doc}/*
        find $LFS/usr/{lib,libexec} -name \*.la -delete
        rm -rf $LFS/tools
    ;;

    * )
        exit
    ;;
esac
echo "Chrooting into ${LFS:?}"

bash -e $DIST_ROOT/build_env/build_scripts/mnt_vfs.sh

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PATH=/usr/bin:/usr/sbin     \
    /bin/bash --login

bash -e $DIST_ROOT/build_env/build_scripts/umnt_vfs.sh
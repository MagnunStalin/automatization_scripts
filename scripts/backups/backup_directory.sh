#!/bin/bash
# Author: Pasantes & Stalin Villacis
# Copy multiples files and directories to external unit

# These functions return exit codes: 0 = found, 1 = not found
isDevMounted () { findmnt --source "$1" >/dev/null;} #device only
isPathMounted() { findmnt --target "$1" >/dev/null;} #path   only
isMounted    () { findmnt          "$1" >/dev/null;} #device or path


DIRECTORIES=("/dir1" "/dir2/dir2_a" "/dir2/dir_b" "dir3/file1")
MOUNT_POINT="/mnt/point_mount"
NETWORK_BACKUP="//network_unit/dir1/dir2"
USERNAME="user"
PASSWORD="password"
DOMAIN="local.local"

set -e
# 1. Verify if the mount point is created
if [ ! -d "$MOUNT_POINT" ]; then
    mkdir $MOUNT_POINT
fi

# 2. Mount netowrk unit
mount -t cifs "$NETWORK_BACKUP"  $MOUNT_POINT -o username=$USERNAME,password=$PASSWORD,domain=$DOMAIN

# 3.Verify is the network unit is mounted
if  isDevMounted "$NETWORK_BACKUP"; then 
    echo "device is mounted"
else 
   echo "device is not mounted"
   exit 1 
fi

# 4. Copy directories
for DIR in "${DIRECTORIES[@]}"; do
    if [ -d "$DIR" ]; then
        rsync -rvz "$DIR" "$MOUNT_POINT"/
    else
        rsync -vz "$DIR" "$MOUNT_POINT"/
    fi
done

#5.Desmontar la unidad de red
umount "$MOUNT_POINT"

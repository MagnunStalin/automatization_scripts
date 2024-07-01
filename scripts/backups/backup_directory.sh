#!/bin/bash
#autor:Pasantes
#Script de automatización para respaldo de archivos adjuntos de fulltime web.
#These functions return exit codes: 0 = found, 1 = not found

isDevMounted () { findmnt --source "$1" >/dev/null;} #device only
isPathMounted() { findmnt --target "$1" >/dev/null;} #path   only
isMounted    () { findmnt          "$1" >/dev/null;} #device or path


directory="/dir1/dir2/dir3"
punto_montaje="/mnt/mount_point_dir"
NETWORK_BACKUP="//external_device/dir1/dir2/dir3"
USERNAME="username"
PASSWORD="passwd"
DOMAIN="local.local"

set -e
#1.Verificar que el punto de montaje se encuentre creado
if [ ! -d "$punto_montaje" ]; then
    mkdir $punto_montaje
fi
#2.Montar la unidad de red
mount -t cifs "$NETWORK_BACKUP"  $punto_montaje -o username=$USERNAME,password=$PASSWORD,domain=$DOMAIN

#3.Verificar si la unidad de red esta montada
if  isDevMounted "$NETWORK_BACKUP";
   then echo "device is mounted"
   else 
   echo "device is not mounted"
   exit 1 
fi

#4.Copiar los respaldos
rsync -rvz "$directory" "$punto_montaje"/

#5.Desmontar la unidad de red
umount "$punto_montaje"

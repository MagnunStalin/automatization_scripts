#!/bin/bash
# AUTOR: Josue Gonzalez

set -e

#Definicion de variables
LOCAL_DIRECTORY="/mnt/dir1/"
NETWORK_BACKUP="//external_device/dir1/dir2/dir3/"
USERNAME="username"
PASSWORD="passwd"
DOMAIN="local.local"
PROYECTO_DIRECTORY="/dir1/dir2/dir3/"

if [ ! -d "$LOCAL_DIRECTORY" ]; then
    mkdir $LOCAL_DIRECTORY
fi

#  Montar la unidad de red

mount -t cifs "$NETWORK_BACKUP"  $LOCAL_DIRECTORY -o username=$USERNAME,password=$PASSWORD,domain=$DOMAIN

#copiar los respaldos al servidor 

 cp -Rvf "${LOCAL_DIRECTORY}"* $PROYECTO_DIRECTORY
 
 # Cambiar propietario y permisos

 chown -R user: $PROYECTO_DIRECTORY
 chmod -R u+rw $PROYECTO_DIRECTORY

 #Desmontar la unidad de red
 umount $LOCAL_DIRECTORY








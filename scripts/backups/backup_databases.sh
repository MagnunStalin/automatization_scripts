#!/bin/bash
# Author: Jouse Gonzales & Alexis Cerda
# Script para respaldar varias bases de datos de un servidor

# Function: Check if a device is mounted
isDevMounted () { findmnt --source "$1" >/dev/null;} #device only

#Variables de entorno 
HOST="localhost"
USER_DB="backup_user"
PASSWD_DB="password"
DBNAMES=(bd1 bd2)
MOUNT_POINT="/mnt/mp_directory"
NETWORK_DIRECTORY="//network_unit/dir1/dir2/dir3"
USERNAME="user_network_unit"
PASSWORD="password"
DOMAIN="local.local"
CURRENT_DATE=$(date +'%d_%m_%Y_%Hh%Mn%Ss')

echo '------------------------------INICIANDO----------------------------------------------'
set -e
#1.Verificar que el punto de montaje se encuentre creado
if [ ! -d "$MOUNT_POINT" ]; then
   mkdir $MOUNT_POINT
fi
#2.Montar la unidad de red
mount -t cifs "$NETWORK_DIRECTORY"  $MOUNT_POINT -o username=$USERNAME,password=$PASSWORD,domain=$DOMAIN

#3.Verificar si la unidad de red esta montada
if  isDevMounted "$NETWORK_DIRECTORY";
   then echo "device is mounted"
   else 
   echo "device is not mounted"
   exit 1 
fi

#4.Recorrer el arreglo de las base de datos
export PGPASSWORD=${PASSWD_DB}
for db in "${DBNAMES[@]}"
do
	#creación de carpeta
	if [ ! -d "${MOUNT_POINT}/${db}" ]; then
		mkdir  "${MOUNT_POINT}/${db}"
	fi
	pg_dump --file "${db}_${CURRENT_DATE}.backup" --host $HOST --port 5432 --username $USER_DB --verbose --format=C --blobs $db

	cp "${db}_${CURRENT_DATE}.backup" "${MOUNT_POINT}/${db}/"
	rm "${db}_${CURRENT_DATE}.backup"
done

#5.Desmontar la unidad de red
umount "$MOUNT_POINT"





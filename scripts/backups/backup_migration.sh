#!/bin/bash
# AUTOR: ALEXIS CERDA
# COPIA LOS ARCHIVOS DE UNA APLICACIÓN A UNA UNIDAD DE RED
# Requisitos
# - Installed cifs-util package

# DETENER LA APLICACIÓN 
sh /home/jboss-5.1.0.GA/bin/shutdown.sh -s 172.16.0.105 -S

# MONTAR LA UNIDAD 
mount -t cifs "//external_device/dir1/dir2/dir3" /mnt/local_point/ -o username=user,password=12345,domain=local.local

# COPIAR LOS RESPALDOS 
cp -Rf /dir1/* /mnt/local_point/

$(/sbin/shutdown -h now)


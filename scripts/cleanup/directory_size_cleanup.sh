#!/bin/bash
# Author: Stalin Villacis
# This script checks the size of a specified directory.
# If the directory size exceeds a specified threshold, it deletes files within the directory to reduce its size. 
# The script can be configured to determine which files to delete based on criteria such as file age or size.

set -e

directory_path_name=$1
limit_size_megabytes=$2

echo "===================================================================================="
echo "Iniciando la tarea"
echo "===================================================================================="
# 1.- Check if directory exists and "directory_path_name" parameter is different of empty.
if [ ! -d "$directory_path_name" ] || [ "$directory_path_name" == "" ]; then
    echo "El directorio no existe"
    exit 1
fi

# 2.- Check if "limit_size_bytes" was set
if [ -z "$limit_size_megabytes" ]; then
    echo "Se requiere especificar el límite de almacenamiento del directorio en megabytes"
    exit 1
fi

# 3.- Get directory size
directory_size_bytes=$(du -bs $directory_path_name | awk '{print $1}')
limit_size_bytes=$(($limit_size_megabytes*$((2**20))))

# 4.- Compare between directory size and limit size allowed
if [ $directory_size_bytes -lt $limit_size_bytes ]; then
    echo "Aún queda espacio..."
    exit 1
fi

# 5.- Remove directory content
rm -rvf "$directory_path_name"/*

echo "===================================================================================="
echo "La tarea se ha finalizado"
echo "===================================================================================="
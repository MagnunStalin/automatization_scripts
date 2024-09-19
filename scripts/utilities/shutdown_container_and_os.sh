#!/bin/bash
# Author: Stalin Villacis
# Stop a container by its name and halt the host server

set -e

CONTAINERS=("sqlserver")

for CONTAINER_NAME in "${CONTAINERS[@]}"; do

    CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    logger "[$CURRENT_TIME] Attempting to stop the container $CONTAINER_NAME by script..."
    docker stop $CONTAINER_NAME

done

logger "[$CURRENT_TIME] All containers stopped successfully . Shutting down the host..."
/sbin/shutdown -h now
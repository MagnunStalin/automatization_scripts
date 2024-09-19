#!/bin/bash
# Author: Stalin Villacis
# Halt the host server

set -e

SERVICES=("postgresql.service")

for SERVICE_NAME in "${SERVICES[@]}"; do

    CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    logger "[$CURRENT_TIME] Attempting to stop the container $SERVICE_NAME by script..."
    systemctl stop $SERVICE_NAME
done

logger "[$CURRENT_TIME] Shutting down the system..."
/sbin/shutdown -h now
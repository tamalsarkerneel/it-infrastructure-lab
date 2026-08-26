#!/bin/bash

# ==========================================
# MikroTik Configuration Backup Automation
# Author: Tamal Sarker
# Version: 1.0
# ==========================================

set -e

# ------------------------------------------
# Configuration
# ------------------------------------------

ROUTER_HOST="192.168.88.1"
ROUTER_USER="backupuser"

BACKUP_DIR="$HOME/mikrotik-backups"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

BACKUP_FILE="$BACKUP_DIR/mikrotik-$DATE.rsc"

# ------------------------------------------
# Create Backup Directory
# ------------------------------------------

mkdir -p "$BACKUP_DIR"

echo "=========================================="
echo "      MIKROTIK CONFIGURATION BACKUP"
echo "=========================================="

echo "Router : $ROUTER_HOST"
echo "Date   : $DATE"
echo "=========================================="

# ------------------------------------------
# Export MikroTik Configuration
# ------------------------------------------

echo
echo "[1] Connecting to MikroTik..."

ssh "$ROUTER_USER@$ROUTER_HOST" \
    "/export" > "$BACKUP_FILE"

echo "Backup created:"
echo "$BACKUP_FILE"

# ------------------------------------------
# Verify Backup
# ------------------------------------------

echo
echo "[2] Verifying backup..."

if [ -s "$BACKUP_FILE" ]; then
    echo "Backup status : SUCCESS"
else
    echo "Backup status : FAILED"
    exit 1
fi

# ------------------------------------------
# Backup Size
# ------------------------------------------

SIZE=$(du -h "$BACKUP_FILE" | cut -f1)

echo "Backup size   : $SIZE"

echo
echo "=========================================="
echo "Backup completed successfully."
echo "=========================================="

#!/bin/bash

# ==========================================
# Linux System Health Check
# Author: Tamal Sarker
# Purpose: Basic Linux infrastructure health monitoring
# ==========================================

HOSTNAME=$(hostname)
DATE=$(date)

echo "=========================================="
echo "        LINUX SYSTEM HEALTH CHECK"
echo "=========================================="
echo "Hostname : $HOSTNAME"
echo "Date     : $DATE"
echo "=========================================="

echo
echo "[1] SYSTEM INFORMATION"
echo "------------------------------------------"

echo "OS:"
cat /etc/os-release | grep PRETTY_NAME

echo "Kernel:"
uname -r

echo "Uptime:"
uptime -p


echo
echo "[2] CPU INFORMATION"
echo "------------------------------------------"

echo "CPU Cores:"
nproc

echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'


echo
echo "[3] MEMORY INFORMATION"
echo "------------------------------------------"

free -h


echo
echo "[4] DISK USAGE"
echo "------------------------------------------"

df -h


echo
echo "[5] TOP CPU PROCESSES"
echo "------------------------------------------"

ps aux --sort=-%cpu | head -6


echo
echo "[6] TOP MEMORY PROCESSES"
echo "------------------------------------------"

ps aux --sort=-%mem | head -6


echo
echo "[7] NETWORK INFORMATION"
echo "------------------------------------------"

ip -brief address


echo
echo "[8] LISTENING PORTS"
echo "------------------------------------------"

ss -tuln


echo
echo "[9] FAILED SYSTEMD SERVICES"
echo "------------------------------------------"

systemctl --failed --no-legend


echo
echo "[10] SYSTEM HEALTH SUMMARY"
echo "------------------------------------------"

echo "Disk Usage:"
df -h / | awk 'NR==2 {print $5 " used"}'

echo "Memory:"
free | awk '/Mem:/ {printf "%.1f%% used\n", $3/$2 * 100}'

echo "Load:"
awk '{print $1}' /proc/loadavg

echo
echo "=========================================="
echo "Health check completed."
echo "=========================================="

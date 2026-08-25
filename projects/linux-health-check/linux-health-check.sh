#!/bin/bash

# ==========================================
# Linux System Health Check
# Author: Tamal Sarker
# Version: 2.0
# ==========================================

HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

CPU_CORES=$(nproc)
LOAD=$(awk '{print $1}' /proc/loadavg)

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "=========================================="
echo "        LINUX SYSTEM HEALTH CHECK"
echo "=========================================="
echo "Hostname : $HOSTNAME"
echo "Date     : $DATE"
echo "=========================================="

echo
echo "[SYSTEM]"
echo "------------------------------------------"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo "Kernel     : $(uname -r)"
echo "CPU Cores  : $CPU_CORES"
echo "Load       : $LOAD"
echo "Memory     : ${MEMORY_USAGE}%"
echo "Disk       : ${DISK_USAGE}%"

echo
echo "[HEALTH STATUS]"
echo "------------------------------------------"

# CPU / Load
if (( $(echo "$LOAD > $CPU_CORES" | bc -l) )); then
    echo "CPU/Load   : WARNING"
else
    echo "CPU/Load   : OK"
fi

# Memory
if [ "$MEMORY_USAGE" -ge 90 ]; then
    echo "Memory     : CRITICAL"
elif [ "$MEMORY_USAGE" -ge 80 ]; then
    echo "Memory     : WARNING"
else
    echo "Memory     : OK"
fi

# Disk
if [ "$DISK_USAGE" -ge 90 ]; then
    echo "Disk       : CRITICAL"
elif [ "$DISK_USAGE" -ge 80 ]; then
    echo "Disk       : WARNING"
else
    echo "Disk       : OK"
fi

echo
echo "[NETWORK]"
echo "------------------------------------------"
ip -brief address

echo
echo "[LISTENING PORTS]"
echo "------------------------------------------"
ss -tuln

echo
echo "[FAILED SERVICES]"
echo "------------------------------------------"

FAILED_SERVICES=$(systemctl --failed --no-legend)

if [ -z "$FAILED_SERVICES" ]; then
    echo "Services   : OK"
else
    echo "$FAILED_SERVICES"
fi

echo
echo "[TOP CPU PROCESSES]"
echo "------------------------------------------"
ps aux --sort=-%cpu | head -6

echo
echo "[TOP MEMORY PROCESSES]"
echo "------------------------------------------"
ps aux --sort=-%mem | head -6

echo
echo "=========================================="
echo "Health check completed."
echo "=========================================="

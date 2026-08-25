# Linux System Health Check

## Overview

A lightweight Bash-based Linux infrastructure health-check script designed to provide a quick overview of system health and resource utilization.

The script collects common operational metrics from a Linux server and presents them in a human-readable format.

---

## 🎯 Objectives

The project demonstrates practical Linux system administration and automation skills.

It checks:

- Operating system
- Kernel version
- System uptime
- CPU information
- Load average
- Memory utilization
- Disk utilization
- Top CPU-consuming processes
- Top memory-consuming processes
- Network interfaces
- Listening ports
- Failed systemd services

---

## 🛠️ Technologies

- Linux
- Bash
- Shell utilities
- systemd
- proc filesystem
- iproute2

---

## 📁 Project Structure

```text
linux-health-check/
│
├── linux-health-check.sh
└── README.md
🚀 Usage

Clone the repository:

git clone <repository-url>

Navigate to the project:

cd projects/linux-health-check

Make the script executable:

chmod +x linux-health-check.sh

Run:

./linux-health-check.sh
📊 Example Output
==========================================
        LINUX SYSTEM HEALTH CHECK
==========================================
Hostname : linux-server
Date     : 2026-08-25
==========================================

[1] SYSTEM INFORMATION
------------------------------------------
OS:
Ubuntu 24.04 LTS

Kernel:
6.x.x

Uptime:
up 12 days

[2] CPU INFORMATION
------------------------------------------

CPU Cores:
4

Load Average:
0.42, 0.35, 0.30

[3] MEMORY INFORMATION
------------------------------------------

              total        used        free
Mem:           8Gi         3Gi         2Gi

[4] DISK USAGE
------------------------------------------

Filesystem      Size  Used Avail Use%
/               100G   42G   53G  45%

[5] TOP CPU PROCESSES
------------------------------------------

...

[6] TOP MEMORY PROCESSES
------------------------------------------

...

[7] NETWORK INFORMATION
------------------------------------------

...

[8] LISTENING PORTS
------------------------------------------

...

[9] FAILED SYSTEMD SERVICES
------------------------------------------

...

[10] SYSTEM HEALTH SUMMARY
------------------------------------------

Disk Usage:
45% used

Memory:
37.5% used

Load:
0.42

==========================================
Health check completed.
==========================================
🔐 Security Considerations

The script is designed primarily for local system administration.

It does not:

Modify system configuration
Change firewall rules
Stop services
Delete files
Change user permissions

The script only collects system information.

🔧 Future Improvements

Possible improvements:

Configurable warning thresholds
Exit codes
Log file generation
Email alerts
JSON output
CSV reporting
CPU threshold detection
Memory threshold detection
Disk threshold detection
Service availability checks
Integration with monitoring platforms
📚 Learning Outcomes

This project demonstrates practical experience with:

Bash scripting
Linux administration
System monitoring
Process management
Network troubleshooting
Disk and memory analysis
Service monitoring
Infrastructure automation

# Linux System Health Check

A lightweight Bash-based Linux infrastructure health monitoring tool that provides a quick overview of system resources, network configuration, running processes, listening ports, and service health.

The project is designed for system administrators and infrastructure engineers who need a simple command-line health check without deploying a full monitoring platform.

---

## 📌 Overview

Maintaining visibility into server health is an essential part of Linux system administration.

This script performs a collection of basic health checks and presents the results in a human-readable format.

It evaluates:

- Operating system information
- Kernel version
- CPU resources
- System load
- Memory utilization
- Disk utilization
- Network interfaces
- Listening ports
- Failed systemd services
- CPU-intensive processes
- Memory-intensive processes

The script also evaluates basic resource thresholds and reports whether the system is operating normally or requires attention.

---

## 🎯 Objectives

The primary objectives of this project are:

- Automate routine Linux health checks
- Reduce repetitive manual commands
- Provide a quick infrastructure health overview
- Detect common resource-related problems
- Identify failed system services
- Provide visibility into listening network ports
- Demonstrate practical Bash scripting
- Build a foundation for infrastructure monitoring automation

---

## 🛠️ Technologies

| Technology | Purpose |
|---|---|
| Bash | Automation and scripting |
| Linux | Target operating system |
| systemd | Service health monitoring |
| proc filesystem | System information |
| iproute2 | Network information |
| ss | Listening port detection |
| ps | Process monitoring |
| df | Disk utilization |
| free | Memory utilization |
| bc | Load calculation |

---

## 📁 Project Structure

```text
linux-health-check/
│
├── linux-health-check.sh
├── README.md
│
└── screenshots/
    ├── health-check-output.png
    └── terminal-output.png
🚀 Installation
Requirements

The script requires:

Linux operating system
Bash
systemd
iproute2
procps
bc

Most modern Linux distributions already include the required utilities.

Debian / Ubuntu

If bc is not installed:

sudo apt update
sudo apt install bc
▶️ Usage

Clone the repository:

git clone <repository-url>

Navigate to the project directory:

cd linux-health-check

Make the script executable:

chmod +x linux-health-check.sh

Run the script:

./linux-health-check.sh

For more complete system information, it may be useful to execute the script with appropriate administrative privileges:

sudo ./linux-health-check.sh
📊 Health Checks

The script performs several categories of checks.

1. System Information

The following information is collected:

Hostname
Operating system
Kernel version
CPU core count
System load
Memory utilization
Disk utilization

Example:

[SYSTEM]
------------------------------------------
Ubuntu 24.04 LTS
Kernel     : 6.x.x
CPU Cores  : 4
Load       : 0.42
Memory     : 37%
Disk       : 45%
🧠 CPU & Load Monitoring

The script checks:

Number of CPU cores
Current system load

The load value is compared against the available CPU capacity to provide a basic indication of CPU pressure.

Example:

CPU/Load   : OK

or:

CPU/Load   : WARNING

This is a basic operational indicator and should not be treated as a replacement for detailed CPU performance monitoring.

💾 Memory Monitoring

The script calculates current memory utilization.

Thresholds
Memory Usage	Status
< 80%	OK
80–89%	WARNING
>= 90%	CRITICAL

Example:

Memory     : OK
💽 Disk Monitoring

The script checks root filesystem utilization.

Thresholds
Disk Usage	Status
< 80%	OK
80–89%	WARNING
>= 90%	CRITICAL

Example:

Disk       : WARNING

High disk utilization can cause:

Application failures
Database problems
Logging failures
Service interruptions
System instability
🌐 Network Information

The script displays configured network interfaces using:

ip -brief address

Example:

lo        UNKNOWN  127.0.0.1/8
eth0      UP       192.168.1.10/24

This provides a quick overview of interface state and assigned addresses.

🔌 Listening Ports

The script checks currently listening TCP and UDP sockets using:

ss -tuln

This can help identify exposed services.

Example:

LISTEN
0.0.0.0:22
0.0.0.0:80
0.0.0.0:443

Unexpected listening ports should be investigated.

⚙️ Failed Services

The script checks systemd for failed services.

Command used:

systemctl --failed

If no failed services are detected:

Services   : OK

If failed services exist, they are displayed for further investigation.

🔥 Top CPU Processes

The script identifies processes currently consuming the highest amount of CPU.

Example:

[TOP CPU PROCESSES]
------------------------------------------
USER       PID  %CPU  %MEM  COMMAND
root      1024  25.4   2.1  process
www-data  2048  12.3   1.8  process

This can help identify abnormal resource consumption.

🧠 Top Memory Processes

The script also displays processes consuming the highest amount of memory.

This can help identify:

Memory-heavy applications
Possible memory leaks
Unexpected processes
Resource contention
🚦 Health Status

The script provides a basic health summary.

Example:

[HEALTH STATUS]
------------------------------------------
CPU/Load   : OK
Memory     : OK
Disk       : WARNING

Possible statuses:

OK
WARNING
CRITICAL
📋 Health Thresholds

Current thresholds:

Resource	OK	Warning	Critical
Memory	< 80%	80–89%	>= 90%
Disk	< 80%	80–89%	>= 90%
CPU Load	Within CPU capacity	Above CPU capacity	—

These values are intentionally simple and can be customized according to the environment.

🔐 Security Considerations

This script is designed as a read-only operational health-check tool.

It does not intentionally:

Modify firewall rules
Stop services
Delete files
Change system configuration
Create users
Modify permissions
Install software

However, commands executed on production systems should always be reviewed before use.

The script should be stored with appropriate file permissions.

🧪 Testing

The script should be tested in a non-production environment before deployment to production infrastructure.

Recommended testing scenarios:

Normal System

Expected:

CPU/Load   : OK
Memory     : OK
Disk       : OK
Services   : OK
High Disk Usage

Expected:

Disk       : WARNING

or:

Disk       : CRITICAL

depending on utilization.

High Memory Usage

Expected:

Memory     : WARNING

or:

Memory     : CRITICAL
Failed Service

Expected:

[FAILED SERVICES]
------------------------------------------
<failed service>
🖥️ Example Output
==========================================
        LINUX SYSTEM HEALTH CHECK
==========================================
Hostname : linux-server
Date     : 2026-08-25 12:00:00
==========================================

[SYSTEM]
------------------------------------------
Ubuntu 24.04 LTS
Kernel     : 6.x.x
CPU Cores  : 4
Load       : 0.42
Memory     : 37%
Disk       : 45%

[HEALTH STATUS]
------------------------------------------
CPU/Load   : OK
Memory     : OK
Disk       : OK

[NETWORK]
------------------------------------------
lo         UNKNOWN  127.0.0.1/8
eth0       UP       192.168.1.10/24

[LISTENING PORTS]
------------------------------------------
0.0.0.0:22
0.0.0.0:80
0.0.0.0:443

[FAILED SERVICES]
------------------------------------------
Services   : OK

[TOP CPU PROCESSES]
------------------------------------------
...

[TOP MEMORY PROCESSES]
------------------------------------------
...

==========================================
Health check completed.
==========================================
📸 Screenshots

Screenshots demonstrating the script running on a Linux system are stored in the screenshots/ directory.

Recommended screenshots:

Normal health check
Warning condition
Failed service detection
Network and listening port information
🔧 Future Improvements

Planned improvements include:

Configurable thresholds
Exit codes based on health status
Log file generation
JSON output
CSV reporting
Email notifications
Telegram/Slack notifications
Service-specific health checks
Network connectivity tests
DNS resolution checks
Internet connectivity checks
SSL certificate expiration checks
Automated scheduled execution
Integration with Uptime Kuma
Integration with LibreNMS
Prometheus integration
Centralized monitoring integration
🤖 Automation Roadmap

The project can gradually evolve from a simple script into a monitoring component.

Basic Health Check
        ↓
Threshold Detection
        ↓
Exit Codes
        ↓
Log Management
        ↓
Scheduled Execution
        ↓
Alerting
        ↓
Monitoring Integration
        ↓
Centralized Observability
📚 Learning Outcomes

This project demonstrates practical experience with:

Linux system administration
Bash scripting
Process monitoring
Resource monitoring
Disk management
Memory analysis
Network troubleshooting
Service monitoring
Port inspection
Shell commands
Basic infrastructure automation
Operational troubleshooting
🔄 Project Philosophy

The purpose of this project is not to replace enterprise monitoring platforms.

Instead, it demonstrates how common infrastructure administration tasks can be converted into a repeatable automation workflow.

The project follows a simple principle:

Manual Checks
     ↓
Automation
     ↓
Standardization
     ↓
Monitoring
     ↓
Alerting
👨‍💻 Author

Tamal Sarker

IT Infrastructure | System Administration | Networking | Automation

GitHub:

https://github.com/tamalsarkerneel

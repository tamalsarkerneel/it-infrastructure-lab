# Linux Server Administration & Hardening

## Overview

Linux is widely used for web servers, application servers, databases, monitoring platforms, containers, network services, and infrastructure automation.

This document covers practical Linux server administration, including **system management, SSH, users and permissions, networking, services, storage, web servers, databases, logging, firewall configuration, automation, and security hardening**.

The examples are intended for laboratory environments and should be adapted to the specific Linux distribution and production requirements.

---

## 🎯 Objectives

The Linux Server Lab focuses on:

* Linux installation and configuration
* User and group management
* File permissions
* SSH administration
* Network configuration
* Package management
* Systemd services
* Web server administration
* Database services
* Firewall configuration
* Log analysis
* Storage management
* Backup
* System hardening
* Automation

---

# 🏗️ Linux Server Architecture

A generalized Linux infrastructure may look like:

```text
                    NETWORK
                       │
                       ▼
                ┌──────────────┐
                │ Router / FW  │
                └──────┬───────┘
                       │
                ┌──────▼───────┐
                │ Linux Server │
                └──────┬───────┘
                       │
          ┌────────────┼────────────┐
          │            │            │
          ▼            ▼            ▼
        Nginx        MariaDB      Monitoring
          │
          ▼
      Application
```

A production environment may separate application, database, monitoring, and management roles across multiple systems.

---

# 🐧 Linux Distribution

Linux server administration varies slightly between distributions.

Common server distributions include:

* Ubuntu Server
* Debian
* Rocky Linux
* AlmaLinux
* Red Hat Enterprise Linux

This laboratory primarily focuses on Debian-based administration concepts, while recognizing differences across distributions.

---

# 👤 Users & Groups

Linux uses users and groups to control access to system resources.

Common commands:

```bash
id
whoami
who
groups
```

Create a user:

```bash
sudo adduser username
```

Create a group:

```bash
sudo groupadd developers
```

Add a user to a group:

```bash
sudo usermod -aG developers username
```

Verify group membership:

```bash
groups username
```

---

# 🔐 File Permissions

Linux permissions are commonly represented as:

```text
r = read
w = write
x = execute
```

Example:

```text
-rwxr-xr--
```

Permissions are assigned to:

```text
Owner
Group
Others
```

View permissions:

```bash
ls -lah
```

Change permissions:

```bash
chmod 750 script.sh
```

Change ownership:

```bash
sudo chown user:group file.txt
```

---

# 🛡️ Principle of Least Privilege

Users and services should have only the permissions required for their tasks.

Avoid unnecessarily running applications as:

```text
root
```

Where possible:

* Use dedicated service accounts
* Restrict file permissions
* Use `sudo`
* Review group membership
* Remove unused accounts

---

# 🔑 SSH Administration

SSH is one of the primary tools for remote Linux administration.

Example:

```bash
ssh username@server-ip
```

SSH configuration is commonly located at:

```text
/etc/ssh/sshd_config
```

After modifying SSH configuration, validate the configuration before restarting the service.

---

# 🔒 SSH Hardening

Recommended security practices include:

* Use SSH keys
* Disable unnecessary authentication methods
* Restrict administrative access
* Disable direct root login where appropriate
* Use firewall restrictions
* Monitor authentication attempts
* Keep OpenSSH updated

An example conceptual policy:

```text
Internet
   │
   ▼
Firewall
   │
   ▼
VPN / Trusted Network
   │
   ▼
SSH
   │
   ▼
Linux Server
```

Changing the SSH port can reduce automated scanning noise, but it should not be treated as a primary security control.

---

# 📦 Package Management

Debian-based systems commonly use APT.

Update package information:

```bash
sudo apt update
```

Upgrade packages:

```bash
sudo apt upgrade
```

Install a package:

```bash
sudo apt install nginx
```

Remove a package:

```bash
sudo apt remove package-name
```

Security updates should be applied according to an appropriate maintenance policy.

---

# ⚙️ Systemd

Modern Linux distributions commonly use systemd for service and system management.

Check service status:

```bash
systemctl status nginx
```

Start service:

```bash
sudo systemctl start nginx
```

Stop service:

```bash
sudo systemctl stop nginx
```

Restart service:

```bash
sudo systemctl restart nginx
```

Enable service at boot:

```bash
sudo systemctl enable nginx
```

---

# 🌐 Network Administration

Useful commands include:

```bash
ip addr
ip route
ip neigh
```

Check connectivity:

```bash
ping <gateway>
```

Check DNS:

```bash
dig example.com
```

Check listening ports:

```bash
ss -tulpen
```

A structured network troubleshooting process should examine:

```text
Interface
   ↓
IP Address
   ↓
Gateway
   ↓
Routing
   ↓
DNS
   ↓
Firewall
   ↓
Application
```

---

# 🌍 Nginx Web Server

Nginx is commonly used as:

* Web server
* Reverse proxy
* TLS termination point
* Load balancer
* Static content server

Typical architecture:

```text
Client
  │
  ▼
Nginx
  │
  ▼
Application
  │
  ▼
Database
```

Check configuration:

```bash
sudo nginx -t
```

Reload configuration:

```bash
sudo systemctl reload nginx
```

---

# 🌐 Apache

Apache HTTP Server is another widely used web server.

Typical responsibilities include:

* HTTP/HTTPS hosting
* Virtual hosts
* Reverse proxy
* Application integration
* TLS

When troubleshooting a web service, separate:

```text
Network
  ↓
Web Server
  ↓
Application
  ↓
Database
```

This prevents configuration changes from being made at the wrong layer.

---

# 🗄️ MariaDB / MySQL

Linux servers commonly host relational databases.

Typical responsibilities include:

* Application data
* User management
* Database backups
* Query processing
* Replication
* Performance monitoring

Security considerations include:

* Strong database credentials
* Restricting remote access
* Least-privilege database accounts
* Regular backups
* Patch management
* Monitoring

---

# 📁 Storage Management

Useful commands:

```bash
lsblk
df -h
du -sh /path/*
```

These help identify:

* Disks
* Partitions
* Mount points
* Filesystem usage
* Large directories

Storage planning should consider:

* Capacity
* Performance
* Redundancy
* Backup
* Recovery requirements

---

# 💾 Mount Management

Linux filesystems can be mounted manually or through persistent configuration.

Important concepts include:

```text
Filesystem
Mount Point
UUID
/etc/fstab
```

Persistent mounts should be tested carefully because an incorrect `/etc/fstab` entry can affect boot behavior.

---

# 📊 System Monitoring

Important metrics include:

* CPU
* RAM
* Disk
* Network
* Load
* Processes
* Services

Useful commands:

```bash
top
free -h
uptime
df -h
free -m
ps aux
```

For deeper infrastructure monitoring, external monitoring systems can collect metrics and alerts centrally.

---

# 📝 Log Management

Linux logs are important for troubleshooting and security analysis.

Depending on the distribution and service, logs may be available through:

```bash
journalctl
```

Examples:

```bash
journalctl -u nginx
```

Recent system messages:

```bash
journalctl -n 50
```

Follow logs:

```bash
journalctl -f
```

Log analysis can help identify:

* Failed authentication
* Service failures
* Application errors
* Network problems
* Unexpected system behavior

---

# 🔥 Firewall

Linux firewall implementation depends on the distribution and architecture.

Common technologies include:

* nftables
* iptables
* UFW
* firewalld

For example, Ubuntu environments may use UFW as a simplified firewall management layer.

Check status:

```bash
sudo ufw status
```

A firewall policy should follow:

```text
Required Traffic → ALLOW
Everything Else → DENY
```

The actual rules should be based on the services running on the server.

---

# 🔐 Linux Hardening

A basic hardening checklist includes:

* Keep the OS updated
* Remove unnecessary packages
* Disable unnecessary services
* Restrict SSH
* Use SSH keys
* Apply least privilege
* Configure firewall
* Monitor logs
* Protect backups
* Use secure file permissions
* Review user accounts
* Monitor listening ports

---

# 🔎 Listening Port Audit

A useful security check is identifying services listening on network ports.

```bash
ss -tulpen
```

Example:

```text
PORT       SERVICE
22         SSH
80         HTTP
443        HTTPS
3306       Database
```

Only required services should be exposed.

---

# 🚨 Process Investigation

Useful commands:

```bash
ps aux
top
htop
```

Investigate unusual:

* CPU consumption
* Memory usage
* Processes
* Network connections
* Background services

Unexpected processes should be investigated before being terminated.

---

# 🧪 Troubleshooting Methodology

A structured Linux troubleshooting process:

```text
Identify Symptoms
       ↓
Check System Resources
       ↓
Check Network
       ↓
Check Service Status
       ↓
Check Logs
       ↓
Check Configuration
       ↓
Test
       ↓
Apply Fix
       ↓
Verify
       ↓
Document
```

---

# 🌐 Web Application Troubleshooting

If an application cannot be accessed:

```text
Client
  │
  ▼
DNS
  │
  ▼
Network
  │
  ▼
Firewall
  │
  ▼
Nginx / Apache
  │
  ▼
Application
  │
  ▼
Database
```

Each layer should be tested independently.

---

# 🔄 Backup Strategy

Critical Linux servers should have appropriate backup coverage.

Potential backup targets:

* Configuration files
* Databases
* Application data
* User files
* Service configuration
* System state where appropriate

A backup process should include:

```text
Backup
  ↓
Verification
  ↓
Retention
  ↓
Recovery Test
```

A backup that has never been restored should not automatically be considered reliable.

---

# ⚙️ Automation

Linux administration can be automated using:

* Bash
* Python
* Ansible
* Cron
* Systemd timers

Potential automation tasks:

```text
Backup
Log cleanup
Health checks
Service monitoring
Disk monitoring
Configuration collection
Security checks
```

---

# ⏰ Scheduled Tasks

Traditional scheduled tasks can use cron.

Example:

```bash
crontab -e
```

A scheduled task should be:

* Documented
* Tested
* Logged
* Monitored

Avoid creating automated tasks without understanding their resource and security impact.

---

# 🔒 Security Monitoring

Important events include:

* SSH authentication failures
* New users
* Privilege changes
* Unexpected services
* Firewall blocks
* Suspicious processes
* Configuration changes
* Unexpected network connections

These logs can later feed centralized monitoring or SIEM systems.

---

# 🧭 Linux Infrastructure Dependencies

A typical web application environment may look like:

```text
                    NETWORK
                       │
                       ▼
                    Nginx
                       │
                       ▼
                 Application
                       │
                       ▼
                    MariaDB
                       │
                       ▼
                   Storage
```

Monitoring and backup should cover each important component.

---

# 🚧 Future Improvements

Planned laboratory work includes:

* Advanced Linux hardening
* SSH security policies
* Fail2ban
* Centralized logging
* Syslog
* Docker
* Container security
* Ansible automation
* MariaDB backup automation
* Nginx reverse proxy
* TLS automation
* Vulnerability scanning
* SIEM integration

---

## 📝 Key Takeaways

Effective Linux administration requires more than knowing commands.

A strong Linux administrator should understand the relationship between:

```text
Users
  ↓
Permissions
  ↓
Processes
  ↓
Services
  ↓
Network
  ↓
Applications
  ↓
Storage
  ↓
Logs
  ↓
Security
  ↓
Backup
```

A structured troubleshooting approach helps identify the actual root cause instead of applying random configuration changes.

Linux security should also be treated as an ongoing process involving **hardening, patching, monitoring, access control, logging, and recovery planning**.

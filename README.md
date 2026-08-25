# IT Infrastructure Lab

A practical and continuously evolving IT infrastructure laboratory focused on **networking, server administration, virtualization, monitoring, backup, automation, and infrastructure security**.

This repository documents hands-on labs, architecture concepts, configuration approaches, troubleshooting methods, and lessons learned from building and managing modern IT infrastructure environments.

---

## 🎯 Objectives

The primary objectives of this lab are to:

* Design and document reliable IT infrastructure
* Build practical networking environments
* Manage Windows and Linux servers
* Implement virtualization and storage solutions
* Monitor infrastructure health and availability
* Develop backup and recovery strategies
* Automate repetitive IT administration tasks
* Apply security hardening principles
* Improve troubleshooting and incident-response skills
* Build a strong foundation for cybersecurity

---

## 🏗️ Infrastructure Architecture

The lab follows a modular infrastructure approach:

```text
                         INTERNET
                             │
                             ▼
                    ┌────────────────┐
                    │    ROUTER /    │
                    │    FIREWALL    │
                    └───────┬────────┘
                            │
                            ▼
                    ┌────────────────┐
                    │  CORE NETWORK  │
                    │    SWITCH      │
                    └───────┬────────┘
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
     ┌─────────┐       ┌──────────┐      ┌─────────┐
     │ Clients │       │ Servers  │      │  Wi-Fi  │
     └─────────┘       └────┬─────┘      └─────────┘
                            │
                    ┌───────┼────────┐
                    │       │        │
                    ▼       ▼        ▼
                 Virtual  Storage  Monitoring
                 Machines   /NAS     System
```

> The architecture shown here is a generalized lab design. No confidential production information, credentials, public IP addresses, or internal company configuration is included.

---

## 🌐 Networking

Networking is one of the core components of this laboratory.

### Topics Covered

* TCP/IP
* IPv4 addressing
* Subnetting
* Routing
* Switching
* DHCP
* DNS
* NAT
* Firewall
* VPN
* WireGuard
* Bandwidth management
* Network troubleshooting
* Network security

### Networking Documentation

* [IP Addressing](networking/ip-addressing.md)
* [Routing](networking/routing.md)
* [Firewall](networking/firewall.md)
* [VPN](networking/vpn.md)

---

## 🖥️ Server Infrastructure

The lab includes both Windows and Linux server administration concepts.

### Windows Server

Topics include:

* Windows Server administration
* Active Directory concepts
* DNS
* DHCP
* IIS
* File services
* Group Policy
* PowerShell administration
* Server security

### Linux Server

Topics include:

* Linux system administration
* SSH
* User and permission management
* Package management
* System services
* Web servers
* Database services
* Firewall configuration
* System hardening

---

## 🧱 Virtualization

Virtualization is used to simulate multiple infrastructure components within a controlled laboratory environment.

### Platform

* Proxmox VE
* Virtual Machines
* Linux containers
* Virtual networking
* Storage management
* Snapshots
* Backup and recovery

---

## 📊 Monitoring

Infrastructure monitoring is essential for maintaining availability and identifying problems before they become major incidents.

### Monitoring Areas

* Server availability
* Network availability
* CPU utilization
* Memory utilization
* Storage utilization
* Network traffic
* Service availability
* System alerts

### Tools

* LibreNMS
* Uptime Kuma
* SNMP
* Native system monitoring tools

---

## 💾 Backup & Recovery

The laboratory follows a basic **3-2-1 backup strategy** concept:

```text
3 Copies
   ↓
2 Different Storage Media
   ↓
1 Off-site / Separate Location
```

Areas covered:

* Configuration backup
* Server backup
* Database backup
* File backup
* Recovery testing
* Backup verification
* Disaster recovery planning

---

## 🔐 Infrastructure Security

Security is treated as a fundamental part of infrastructure design.

### Security Areas

* Firewall configuration
* Secure remote administration
* SSH hardening
* Windows security
* Linux hardening
* Access control
* Strong authentication
* Least privilege
* Network segmentation concepts
* Logging and monitoring
* Secure backup practices

---

## ⚙️ Automation

Repetitive administrative tasks are gradually automated using:

* PowerShell
* Bash
* Python
* MikroTik scripting

Examples include:

* Automated backups
* Configuration collection
* System checks
* Monitoring tasks
* Log processing
* Administrative utilities

---

## 🛠️ Troubleshooting Methodology

Infrastructure troubleshooting follows a structured approach:

```text
Identify
   ↓
Collect Information
   ↓
Isolate the Problem
   ↓
Test Hypothesis
   ↓
Apply Fix
   ↓
Verify
   ↓
Document
```

The goal is not only to fix the immediate issue but also to identify the root cause and prevent recurrence.

---

## 📚 Documentation Philosophy

Every lab project aims to document:

1. Problem / Objective
2. Architecture
3. Technologies
4. Implementation
5. Configuration
6. Security considerations
7. Testing
8. Troubleshooting
9. Lessons learned
10. Future improvements

---

## 🚧 Project Status

**Status:** Active / Continuously Evolving

This laboratory will be expanded over time with additional infrastructure, automation, monitoring, networking, and cybersecurity projects.

---

## 🔮 Future Improvements

Planned areas include:

* Advanced network segmentation
* Centralized logging
* Security monitoring
* SIEM laboratory
* Vulnerability assessment
* Incident response exercises
* Infrastructure automation
* Infrastructure-as-Code
* Containerized services
* Advanced backup and disaster recovery
* Cybersecurity-focused network architecture

---

## 👤 Author

**Tamal Sarker**

IT Executive
IT Infrastructure | Network & Systems Administration | Virtualization | Cybersecurity

---

⭐ This repository represents a practical learning and experimentation environment. Production environments should always be adapted according to organizational policies, security requirements, and compliance standards.

# Windows Server Infrastructure & Administration

## Overview

Windows Server provides a broad platform for enterprise identity management, networking services, application hosting, file services, and centralized administration.

This document covers the core Windows Server components used in an infrastructure laboratory, including **Active Directory Domain Services, DNS, DHCP, IIS, Group Policy, PowerShell, server administration, and security hardening**.

The configurations described here are generalized laboratory concepts and do not contain confidential production information.

---

## 🎯 Objectives

The Windows Server lab focuses on:

* Windows Server deployment
* Active Directory administration
* DNS infrastructure
* DHCP services
* IIS web hosting
* Group Policy
* File and folder permissions
* PowerShell administration
* Server monitoring
* Backup
* Security hardening
* Troubleshooting

---

# 🏗️ Windows Server Architecture

A generalized Windows infrastructure may look like:

```text
                         NETWORK
                            │
                            ▼
                    ┌──────────────┐
                    │    Router    │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ Core Network │
                    └──────┬───────┘
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
       Domain Controller  IIS        File Server
             │
             ├── AD DS
             ├── DNS
             └── Group Policy
```

Additional infrastructure services can be added according to organizational requirements.

---

# 🏢 Active Directory Domain Services

Active Directory Domain Services (AD DS) provides centralized identity and resource management.

It can be used to manage:

* Users
* Groups
* Computers
* Servers
* Organizational Units
* Policies
* Authentication
* Authorization

A simplified architecture:

```text
Active Directory Domain
          │
     ┌────┴────┐
     │         │
   Users     Computers
     │         │
     ▼         ▼
 Authentication
     │
     ▼
 Group Policy
```

---

# 👤 Organizational Units

Organizational Units (OUs) help organize users, computers, and other directory objects.

Example:

```text
Company
│
├── Users
│   ├── IT
│   ├── Accounts
│   ├── HR
│   └── Operations
│
├── Computers
│   ├── Workstations
│   └── Laptops
│
└── Servers
```

OU design should reflect administrative and policy requirements rather than simply copying the physical organization chart.

---

# 👥 User & Group Management

A centralized directory makes it easier to manage:

* User accounts
* Security groups
* Password policies
* Access permissions
* Application access
* Administrative privileges

The principle of **least privilege** should be applied to administrative roles.

---

# 🔐 Authentication & Authorization

These concepts should be treated separately.

### Authentication

Answers:

> Who are you?

### Authorization

Answers:

> What are you allowed to access?

Example:

```text
User
 │
 ▼
Authentication
 │
 ▼
Group Membership
 │
 ▼
Authorization
 │
 ▼
Resource Access
```

---

# 🌐 DNS

DNS is a critical dependency of Active Directory.

A domain environment relies heavily on correct DNS resolution.

Example:

```text
Client
  │
  ▼
DNS Server
  │
  ▼
Domain Controller
  │
  ▼
Active Directory Services
```

Important DNS records may include:

* A
* AAAA
* CNAME
* MX
* PTR
* SRV

Active Directory uses SRV records to help clients locate domain services.

---

# 📡 DHCP

DHCP automatically provides network configuration to clients.

Typical DHCP options include:

```text
IP Address
Subnet Mask
Default Gateway
DNS Server
DNS Domain
Lease Duration
```

Example:

```text
DHCP Scope
192.168.30.0/24

Pool:
192.168.30.100 - 192.168.30.240

Gateway:
192.168.30.1

DNS:
192.168.20.10
```

---

# 🔄 DHCP Authorization

In an Active Directory environment, DHCP server authorization is an important administrative control.

Only authorized DHCP servers should provide addresses to clients on managed networks.

This helps reduce the risk of an unauthorized DHCP server distributing incorrect network configuration.

---

# 🌐 IIS Web Server

Internet Information Services (IIS) is Microsoft's web server platform.

It can host:

* Websites
* Web applications
* APIs
* PHP applications
* ASP.NET applications
* Static content

A simplified architecture:

```text
Client
  │
  ▼
HTTP / HTTPS
  │
  ▼
IIS
  │
  ├── Website
  ├── Application
  └── Backend Services
```

---

# 🔒 HTTPS

Production web applications should use HTTPS where appropriate.

A typical HTTPS flow:

```text
Client
  │
  │ TLS
  ▼
IIS
  │
  ▼
Web Application
```

TLS certificates should be managed securely and renewed before expiration.

---

# 📁 File Server

Windows Server can provide centralized file services.

A basic structure:

```text
File Server
│
├── Departments
│   ├── HR
│   ├── Accounts
│   ├── IT
│   └── Merchandising
│
└── Shared
```

Access should be controlled using appropriate security groups and permissions.

---

# 🔐 NTFS & Share Permissions

Windows file access may involve both:

* Share permissions
* NTFS permissions

Effective access should be designed carefully to avoid accidental over-permissioning.

A common principle is:

```text
Users
  ↓
Security Groups
  ↓
Resource Permissions
```

Avoid assigning permissions individually to large numbers of users where group-based access is more appropriate.

---

# 📜 Group Policy

Group Policy provides centralized configuration and security management for domain-joined systems.

Possible policies include:

* Password policy
* Account lockout
* Windows Firewall
* Windows Defender
* Software restrictions
* Desktop configuration
* USB/device controls
* Windows Update
* Security settings
* Audit policies

Example:

```text
Domain
  │
  ▼
Organizational Unit
  │
  ▼
Group Policy
  │
  ▼
Computer / User
```

---

# 🛡️ Windows Server Hardening

Server hardening should reduce unnecessary attack surface.

Recommended practices include:

### Account Security

* Strong administrator credentials
* Least privilege
* Separate administrative accounts
* Remove unnecessary accounts
* Review privileged groups

### Network Security

* Windows Firewall
* Restrict management ports
* Secure remote administration
* Disable unnecessary services

### System Security

* Regular security updates
* Microsoft Defender
* Security auditing
* Event log monitoring
* Secure configuration

### Application Security

* Remove unused applications
* Keep web applications updated
* Use HTTPS
* Restrict IIS access
* Protect configuration files

---

# 🧑‍💻 PowerShell Administration

PowerShell is an important automation and administration tool for Windows environments.

Example:

```powershell
Get-ComputerInfo
```

List services:

```powershell
Get-Service
```

Check IP configuration:

```powershell
Get-NetIPConfiguration
```

Check listening TCP connections:

```powershell
Get-NetTCPConnection -State Listen
```

Query event logs:

```powershell
Get-WinEvent -LogName System -MaxEvents 20
```

The goal is to use PowerShell not only for one-off commands but also for repeatable administration and automation.

---

# 📊 Windows Event Logs

Important Windows logs include:

```text
Application
Security
System
Setup
Forwarded Events
```

Security logs can be particularly useful for investigating:

* Authentication failures
* Account changes
* Privilege changes
* Policy changes
* Suspicious activity

Centralized logging can be introduced as the infrastructure grows.

---

# 💾 Windows Server Backup

A backup strategy should protect:

* System state
* Application data
* Databases
* File shares
* Configuration
* Critical services

A basic strategy:

```text
Production Data
      │
      ▼
Primary Backup
      │
      ▼
Secondary / Off-site Copy
      │
      ▼
Recovery Testing
```

Backups should be periodically tested rather than assuming that a successful backup job automatically guarantees recoverability.

---

# 🧪 Troubleshooting Methodology

A structured Windows Server troubleshooting process:

```text
Identify Problem
      ↓
Collect Evidence
      ↓
Check Event Logs
      ↓
Check Services
      ↓
Check Network
      ↓
Check DNS
      ↓
Check Permissions
      ↓
Test Configuration
      ↓
Apply Fix
      ↓
Verify
      ↓
Document
```

---

# 🔎 Common Troubleshooting Areas

## DNS Problem

Symptoms:

* Domain login issues
* Website resolution failure
* Service discovery problems

Check:

```text
DNS Server
DNS Records
Client DNS Configuration
SRV Records
Connectivity
```

---

## DHCP Problem

Symptoms:

* Client receives `169.254.x.x`
* Incorrect gateway
* Incorrect DNS
* IP conflicts

Check:

```text
DHCP Service
Scope
Address Pool
Reservations
Authorization
Network Connectivity
```

---

## Active Directory Problem

Symptoms:

* Login failure
* Domain join failure
* Group Policy not applying

Check:

```text
DNS
Time Synchronization
Domain Controller Availability
Replication
Computer Account
Group Policy
```

---

# ⏱️ Time Synchronization

Accurate time is important in domain environments.

Kerberos authentication is sensitive to time differences between systems.

Therefore:

```text
Domain Controller
       │
       ▼
Time Synchronization
       │
       ▼
Domain Members
```

Time configuration should be properly designed and monitored.

---

# 🔐 Remote Administration

Remote administration should be restricted and secured.

Possible tools include:

* Remote Desktop
* PowerShell Remoting
* Windows Admin Center
* MMC-based administration
* Server Manager

Administrative access should preferably be limited to trusted management networks or VPN-connected administrators.

---

# 🧭 Infrastructure Dependencies

A Windows environment contains several interconnected services:

```text
                    Active Directory
                          │
              ┌───────────┼───────────┐
              │           │           │
             DNS        DHCP        GPO
              │                       │
              └───────────┬───────────┘
                          │
                       Clients
```

A failure in DNS, time synchronization, or network connectivity can affect multiple services simultaneously.

Understanding these dependencies is critical for troubleshooting.

---

# 🔒 Security Monitoring

Important monitoring areas include:

* Failed logins
* Privileged account activity
* New user creation
* Group membership changes
* Service changes
* Firewall events
* Security log anomalies
* PowerShell activity
* Endpoint security alerts

These events can later be integrated into centralized logging or SIEM platforms.

---

# 🚧 Future Improvements

Planned laboratory improvements include:

* Active Directory Domain Services lab
* Group Policy security baseline
* PowerShell automation
* Windows Server monitoring
* Centralized Windows event collection
* Microsoft Defender security monitoring
* Certificate Services
* IIS application hosting
* Backup and recovery testing
* Windows security auditing
* SIEM integration

---

## 📝 Key Takeaways

A Windows Server environment is not simply a collection of individual services.

Reliable infrastructure depends on understanding the relationships between:

```text
Network
  ↓
DNS
  ↓
Active Directory
  ↓
Authentication
  ↓
Group Policy
  ↓
Applications
  ↓
Monitoring
  ↓
Security
  ↓
Backup
```

A strong Windows administrator should therefore understand not only how to configure individual services, but also how those services interact, how failures propagate, and how to troubleshoot them systematically.

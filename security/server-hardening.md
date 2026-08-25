# Server & Infrastructure Security Hardening

## Overview

Infrastructure security hardening is the process of reducing the attack surface, enforcing secure configurations, controlling access, monitoring activity, and maintaining systems throughout their lifecycle.

Hardening should be applied across:

- Windows Servers
- Linux Servers
- Proxmox
- Network Devices
- Virtual Machines
- Applications
- Management Interfaces

The objective is not simply to block attacks, but to build infrastructure that is secure, observable, maintainable, and recoverable.

---

# 🎯 Security Objectives

The infrastructure security baseline focuses on:

- Attack surface reduction
- Least privilege
- Secure authentication
- Access control
- Patch management
- Network security
- Service hardening
- Logging
- Monitoring
- Backup protection
- Configuration management
- Incident readiness

---

# 🧱 Defense in Depth

Infrastructure security should use multiple layers of protection.

```text
                    Internet
                       │
                       ▼
                 Edge Firewall
                       │
                       ▼
                Network Security
                       │
                       ▼
                Server Hardening
                       │
                       ▼
               Application Security
                       │
                       ▼
                  Data Security
                       │
                       ▼
                 Backup / Recovery

If one security control fails, other layers should continue providing protection.

🔐 Least Privilege

Users, services, and applications should receive only the permissions they actually require.

Example:

User
  │
  ├── Required Access → ALLOW
  │
  └── Unnecessary Access → DENY

Avoid using highly privileged accounts for routine tasks.

👤 Administrative Accounts

Administrative access should be separated from normal user activity where practical.

Recommended model:

Daily User Account
       │
       └── Normal Activities

Administrative Account
       │
       └── Administrative Tasks

This reduces the impact of compromised everyday credentials.

🔑 Password Security

Strong authentication should include:

Long passwords
Unique passwords
Password managers
Account lockout controls where appropriate
MFA for privileged systems
Removal of unused accounts

Never store passwords in:

Git repositories
Source code
Configuration files committed publicly
Documentation
Chat messages
🛡️ Multi-Factor Authentication

MFA adds another authentication factor beyond a password.

Conceptually:

Password
   +
Second Factor
   ↓
Authentication

MFA should be prioritized for:

Administrator accounts
VPN
Cloud services
Remote management
Backup systems
Monitoring systems
🔒 Management Plane Security

Administrative interfaces are high-value targets.

Examples:

RDP
SSH
Winbox
Proxmox Web UI
Web administration panels
Network device management

Preferred architecture:

Administrator
      │
      ▼
     VPN
      │
      ▼
Management Network
      │
 ┌────┼───────────────┐
 ▼    ▼               ▼
SSH  Winbox        Proxmox

Management services should not be unnecessarily exposed to the public Internet.

🌐 Network Segmentation

Network segmentation reduces the blast radius of a compromise.

Example:

                 Core Network
                      │
       ┌──────────────┼──────────────┐
       │              │              │
       ▼              ▼              ▼
    Servers         Users        Management
       │
       ▼
   Applications

Where appropriate, VLANs and firewall policies can enforce separation.

🔥 Firewall Strategy

A secure firewall should follow a default-deny approach where practical.

Conceptually:

Required Traffic
       │
       ▼
     ALLOW

Everything Else
       │
       ▼
     DENY

Firewall rules should be:

Documented
Minimal
Reviewed
Logged where appropriate
Tested after changes
🚪 Attack Surface Reduction

Every unnecessary service increases the potential attack surface.

Review:

Listening Ports
Running Services
Installed Software
Remote Access
Management Interfaces
Unused Accounts

Useful Linux command:

ss -tulpen

Useful Windows command:

Get-NetTCPConnection -State Listen

Only required services should remain enabled.

🐧 Linux Hardening

A Linux security baseline should include:

Regular updates
Secure SSH configuration
Least-privilege users
Firewall
File permissions
Service minimization
Log monitoring
Time synchronization
Backup
Malware/security monitoring where appropriate
🔑 SSH Hardening

Important SSH controls include:

SSH keys
Restricted administrative access
Disable direct root login where appropriate
Restrict unnecessary users
Firewall restrictions
Logging
Regular patching

Example:

Internet
   X
   │
   │ SSH
   ▼
Firewall
   │
   ▼
VPN / Trusted Network
   │
   ▼
Linux Server

Changing the SSH port may reduce automated scanning noise, but it is not a replacement for authentication and firewall security.

🪟 Windows Server Hardening

Windows Server security should include:

Security updates
Strong authentication
Restricted RDP
Windows Firewall
Least privilege
Local account management
Service review
Event Log monitoring
Endpoint protection
Backup
Secure administrative access
🖥️ RDP Security

Remote Desktop should not be unnecessarily exposed to the public Internet.

Preferred:

Administrator
      │
      ▼
VPN / Secure Access
      │
      ▼
RDP
      │
      ▼
Windows Server

Additional controls may include:

Network Level Authentication
MFA through appropriate access solutions
Firewall restrictions
Account lockout policies
Logging
🧱 Proxmox Hardening

Proxmox is a critical infrastructure management platform.

Security considerations include:

Strong administrator credentials
MFA
Restricted management access
Firewall
Regular updates
Secure API access
Backup protection
Audit logging
Limited administrative privileges

Management access should ideally be restricted to trusted networks or VPN.

🌐 Network Device Hardening

Network infrastructure should also be hardened.

Examples:

MikroTik
Cisco
Firewalls
Switches
Wireless controllers

Baseline controls:

Disable unused services
        ↓
Restrict management access
        ↓
Use secure authentication
        ↓
Apply firewall rules
        ↓
Enable logging
        ↓
Backup configuration
        ↓
Keep firmware updated
📡 MikroTik Security Baseline

For MikroTik infrastructure:

Restrict Winbox access
Restrict API access
Disable unused services
Use strong administrator credentials
Apply firewall policies
Restrict management by source network
Keep RouterOS updated
Backup configuration
Monitor logs

Management services should not be unnecessarily reachable from the Internet.

🔍 Service Enumeration

Regularly identify services running on servers.

Linux:

systemctl --type=service

Windows:

Get-Service

Network devices should also be reviewed for enabled management services.

The objective is:

Required Service → Keep
Unused Service   → Disable
Unknown Service  → Investigate
📦 Patch Management

Unpatched systems can contain known vulnerabilities.

A patch management lifecycle:

Identify Updates
      ↓
Assess Risk
      ↓
Test
      ↓
Deploy
      ↓
Verify
      ↓
Document

Critical infrastructure should have a defined maintenance process.

🧪 Vulnerability Management

Security is not limited to patching.

A vulnerability management process may include:

Asset Discovery
      ↓
Vulnerability Scanning
      ↓
Risk Assessment
      ↓
Prioritization
      ↓
Remediation
      ↓
Verification

Prioritize vulnerabilities based on:

Severity
Exposure
Exploitability
Asset criticality
Business impact
📝 Security Logging

Important security events should be logged.

Examples:

Login Success
Login Failure
Privilege Change
Configuration Change
Firewall Block
Service Start/Stop
Account Creation
Account Deletion

Logs should be protected against unauthorized modification.

📊 Centralized Logging

For larger environments, centralized logging can improve visibility.

Example:

Windows Server ──┐
Linux Server ────┤
MikroTik ────────┤
Proxmox ─────────┤
Firewall ────────┤
                 ▼
        Central Log Platform
                 │
                 ▼
             Analysis
                 │
                 ▼
              Alert

Centralized logs make cross-system investigation easier.

⏰ Time Synchronization

Accurate time is important for:

Log correlation
Authentication
Certificates
Monitoring
Incident investigation

Systems should use a reliable time synchronization mechanism.

Example:

NTP
 │
 ├── Router
 ├── Server
 ├── Proxmox
 └── Network Devices
🔐 TLS / HTTPS

Administrative interfaces and applications should use secure encrypted communication where appropriate.

HTTP
  ↓
HTTPS
  ↓
TLS Encryption

Certificates should be:

Valid
Properly configured
Monitored for expiration
Renewed before expiry
💾 Backup Security

Backups must also be protected.

Security controls include:

Separate credentials
Restricted access
Encryption
Immutable storage where appropriate
Offline copies
Monitoring
Restore testing

A compromised backup system can significantly increase the impact of an incident.

🧩 Configuration Management

Security configurations should be documented and preferably managed consistently.

Examples:

Firewall Rules
SSH Configuration
Windows Policies
MikroTik Configuration
Proxmox Settings
User Permissions

Configuration changes should be:

Requested
   ↓
Reviewed
   ↓
Implemented
   ↓
Tested
   ↓
Documented
🧯 Incident Response Readiness

Infrastructure should be prepared for security incidents.

Basic process:

Detect
  ↓
Validate
  ↓
Contain
  ↓
Investigate
  ↓
Eradicate
  ↓
Recover
  ↓
Review

Examples of incidents:

Compromised account
Malware
Suspicious login
Unauthorized configuration change
Ransomware
Data exposure
Network intrusion
🚨 Compromised Account Scenario

Example:

Suspicious Login
       ↓
Validate Activity
       ↓
Disable / Restrict Account
       ↓
Revoke Sessions / Credentials
       ↓
Review Logs
       ↓
Identify Scope
       ↓
Reset Credentials
       ↓
Check Persistence
       ↓
Monitor
       ↓
Document Incident

Actions should follow the organization's incident response procedure.

🧠 Security Baseline Checklist
Authentication
 Strong passwords
 MFA
 Separate admin accounts
 Remove unused accounts
 Review privileged access
Network
 Firewall enabled
 Management restricted
 Unnecessary ports blocked
 Segmentation implemented where appropriate
Server
 OS patched
 Unnecessary services disabled
 Secure SSH/RDP
 Endpoint protection
 Logging enabled
Virtualization
 Proxmox updated
 Management restricted
 MFA enabled
 Firewall configured
 Backups protected
Network Devices
 RouterOS/firmware updated
 Unused services disabled
 Management restricted
 Configuration backup
 Logging enabled
Backup
 3-2-1 strategy
 Off-site copy
 Access separation
 Restore testing
 Backup monitoring
📋 Security Audit Checklist

A periodic infrastructure security review can follow:

1. Asset Inventory
2. Account Review
3. Privilege Review
4. Service Review
5. Port Review
6. Patch Review
7. Firewall Review
8. Log Review
9. Backup Review
10. Vulnerability Assessment
11. Configuration Review
12. Recovery Test
🔄 Continuous Security Improvement

Security should be treated as an ongoing lifecycle.

Assess
  ↓
Harden
  ↓
Monitor
  ↓
Detect
  ↓
Respond
  ↓
Recover
  ↓
Improve
  ↓
Assess Again

There is no single configuration that makes infrastructure permanently secure.

🚧 Future Improvements

Planned security work includes:

Linux CIS-style hardening
Windows security baseline
MikroTik firewall hardening
Proxmox security baseline
Fail2ban
Centralized logging
SIEM integration
Vulnerability scanning
Network segmentation
MFA
Privileged Access Management
Security incident playbooks
📝 Key Takeaways

Infrastructure security is a combination of:

Identity
   +
Access Control
   +
Network Security
   +
System Hardening
   +
Patch Management
   +
Logging
   +
Monitoring
   +
Backup
   +
Incident Response

The goal of hardening is to reduce attack surface, limit unauthorized access, detect suspicious activity, and maintain the ability to recover when preventive controls fail.

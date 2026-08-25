# Backup & Disaster Recovery Strategy

## Overview

Backup and Disaster Recovery (DR) are critical components of reliable IT infrastructure.

A backup protects data from accidental deletion, hardware failure, corruption, ransomware, configuration mistakes, and other incidents.

Disaster Recovery defines how systems and services will be restored after a major failure.

This document describes practical backup concepts including **3-2-1 backup strategy, RPO, RTO, server backup, database backup, virtualization backup, restore testing, retention, and disaster recovery planning**.

---

## 🎯 Objectives

This backup and recovery strategy focuses on:

- Data protection
- System recovery
- Backup architecture
- Disaster recovery
- RPO and RTO
- Backup retention
- Restore testing
- Virtual machine backup
- Database backup
- Configuration backup
- Off-site protection
- Recovery documentation

---

# 💾 Backup vs Disaster Recovery

Backup and Disaster Recovery are related but different.

### Backup

Backup means creating a recoverable copy of data or system information.

### Disaster Recovery

Disaster Recovery defines how critical services will be restored after a major incident.

Conceptually:

```text
Production
    │
    ▼
  Backup
    │
    ▼
Recovery
    │
    ▼
Restored Service
🏗️ Backup Architecture

A generalized architecture:

                    Production
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
       Servers          VMs        Databases
          │             │             │
          └─────────────┼─────────────┘
                        │
                        ▼
                 Backup System
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
       Local Backup           Off-site Copy
             │                     │
             └──────────┬──────────┘
                        ▼
                  Recovery Testing
🔢 3-2-1 Backup Strategy

A commonly used backup principle is the 3-2-1 strategy.

It means:

3 Copies of Data
2 Different Storage Media
1 Copy Off-site

Example:

Production Data
      │
      ├── Primary Storage
      │
      ├── Local Backup
      │
      └── Off-site Backup

The objective is to reduce the risk that a single incident destroys every copy.

🛡️ Modern Backup Considerations

The traditional 3-2-1 strategy can be strengthened with additional controls such as:

Offline copies
Immutable backups
Access-controlled backup repositories
Encryption
Backup monitoring
Restore testing

A practical strategy may therefore resemble:

Production
    │
    ├── Local Backup
    │
    ├── Secondary Backup
    │
    └── Off-site / Offline / Immutable Copy
⏱️ RPO

Recovery Point Objective (RPO) defines the maximum acceptable amount of data loss measured in time.

Example:

RPO = 4 Hours

This means the organization is prepared to potentially lose up to approximately four hours of data, depending on the backup design and failure timing.

⚡ RTO

Recovery Time Objective (RTO) defines the target time within which a service should be restored.

Example:

RTO = 2 Hours

This means the target is to restore the affected service within approximately two hours.

📊 RPO vs RTO
Concept	Question
RPO	How much data can we afford to lose?
RTO	How quickly must the service return?

Example:

Incident
   │
   ├── RPO → Data Loss Window
   │
   └── RTO → Recovery Time Window

Both should be defined according to business requirements.

🏢 Business Criticality

Not every system requires the same backup frequency or recovery target.

Example:

System	Priority	RPO	RTO
Core Application	Critical	Short	Short
Database	Critical	Short	Short
File Server	High	Moderate	Moderate
Monitoring	Medium	Longer	Moderate
Test VM	Low	Longer	Longer

These values are examples only and should be determined through business impact analysis.

🧩 Backup Types

Common backup approaches include:

Full Backup

Copies the complete selected dataset.

Incremental Backup

Copies changes since the previous backup.

Differential Backup

Copies changes since the last full backup.

Snapshot

Captures a point-in-time state of a system or dataset.

Snapshots can be useful for operational recovery but should not automatically be treated as independent backups.

🖥️ Virtual Machine Backup

Virtualization platforms such as Proxmox can be integrated into a backup strategy.

Example:

Proxmox
   │
   ├── VM 101
   ├── VM 102
   ├── VM 103
   └── LXC
        │
        ▼
     Backup

Backup planning should consider:

VM priority
Backup frequency
Retention
Storage capacity
Encryption
Restore testing
📦 Application Backup

Application data may require application-aware backup.

Examples:

Web Application
      │
      ├── Application Files
      ├── Configuration
      └── Database

Backing up only the VM does not eliminate the need to understand how the application itself should be recovered.

🗄️ Database Backup

Databases require special attention because data consistency is critical.

Potential strategies include:

Logical database dumps
Physical backups
Replication
Application-aware backups
Point-in-time recovery

Example concept:

Application
    │
    ▼
Database
    │
    ├── Backup
    ├── Verification
    └── Restore Test
🔐 Database Backup Security

Database backups may contain sensitive information.

Protect them using:

Access control
Encryption
Secure storage
Limited administrative access
Retention policies
Monitoring

Never commit real database dumps or credentials to a public GitHub repository.

⚙️ Configuration Backup

Infrastructure configuration should also be backed up.

Examples:

Router Configuration
Switch Configuration
Firewall Configuration
Proxmox Configuration
Application Configuration
DNS Configuration

A configuration backup can significantly reduce recovery time after hardware replacement or configuration loss.

🌐 Network Device Backup

Network devices should have automated configuration backup where possible.

Example:

Network Device
      │
      ▼
Scheduled Backup
      │
      ▼
Backup Repository
      │
      ▼
Versioned Configuration

Configuration versions make it easier to identify what changed before an incident.

🔒 Backup Security

Backup systems themselves are high-value targets.

Recommended controls include:

Separate backup credentials
Least privilege
MFA where supported
Network isolation
Encryption
Immutable storage where appropriate
Offline copies
Access logging
Regular restore tests
🦠 Ransomware Protection

A backup strategy should consider ransomware.

A simplified attack scenario:

Attacker
   │
   ▼
Production Systems
   │
   ▼
Data Encrypted
   │
   ▼
Backup System Targeted

If backups are directly accessible with the same credentials and privileges as production systems, they may also be compromised.

Therefore:

Production Credentials
        ≠
Backup Administrative Credentials

Separation of access is an important defensive measure.

🧊 Offline / Immutable Backups

An offline or immutable backup can provide additional protection against destructive incidents.

Example:

Production
    │
    ▼
Backup
    │
    ▼
Immutable / Offline Copy

The exact implementation depends on the backup platform and infrastructure.

📅 Backup Schedule

A sample schedule:

Daily
 ├── Incremental Backup
 └── Configuration Backup

Weekly
 └── Full / Consolidated Backup

Monthly
 └── Long-Term Retention Copy

Periodic
 └── Restore Test

Actual frequency should be based on RPO, business requirements, data change rate, and available resources.

🗃️ Retention Policy

A backup retention policy defines how long different backup generations are preserved.

Example:

Daily     → 7 Days
Weekly    → 4 Weeks
Monthly   → 12 Months

Retention should be aligned with:

Business requirements
Compliance
Storage capacity
Recovery requirements
🧪 Backup Verification

A successful backup job does not automatically prove that the data is recoverable.

Verification should include:

Backup Created
      ↓
Backup Integrity Check
      ↓
Restore
      ↓
Application Test
      ↓
Data Verification
      ↓
Recovery Documented
🔄 Restore Testing

Restore testing should be performed periodically.

A basic test:

Select Backup
      ↓
Restore to Isolated Environment
      ↓
Boot System
      ↓
Check Services
      ↓
Check Data
      ↓
Check Network
      ↓
Record Recovery Time
      ↓
Document Result
🚨 Disaster Recovery Scenario

Example scenario:

Primary virtualization host fails unexpectedly.

Possible recovery process:

Host Failure
     │
     ▼
Identify Affected Services
     │
     ▼
Activate Recovery Plan
     │
     ▼
Provision / Prepare Recovery Host
     │
     ▼
Restore Critical VM
     │
     ▼
Verify Network
     │
     ▼
Verify Application
     │
     ▼
Restore User Access
     │
     ▼
Monitor
🔥 Hardware Failure

For a hardware failure:

Hardware Failure
      │
      ▼
Backup Available?
      │
 ┌────┴────┐
 No        Yes
 │          │
Manual      Restore
Recovery     │
             ▼
         Verify Service

Hardware redundancy can reduce downtime, but backups remain important for data recovery.

🌐 Site Failure

If the entire primary location becomes unavailable:

Primary Site
     │
     X
     │
     ▼
Disaster
     │
     ▼
Secondary / Off-site Location
     │
     ▼
Recovery Systems

A true disaster recovery plan should define:

Alternate infrastructure
Recovery sequence
Network connectivity
DNS changes
Data restoration
Communication
Responsibilities
📋 Recovery Priority

Services should be restored according to business priority.

Example:

1. Network / Connectivity
2. Identity / Authentication
3. DNS
4. Database
5. Core Application
6. File Services
7. Supporting Services
8. Non-critical Systems

The actual sequence depends on service dependencies.

🔗 Service Dependencies

Recovery planning must understand dependencies.

Example:

Application
    │
    ▼
Database
    │
    ▼
Storage

User Authentication
    │
    ▼
Active Directory
    │
    ▼
DNS
    │
    ▼
Network

Restoring a dependent application before its required infrastructure may not produce a working service.

📝 Disaster Recovery Runbook

A recovery runbook should contain:

System Name
System Owner
Criticality
Dependencies
Backup Location
Latest Verified Backup
RPO
RTO
Recovery Procedure
Validation Procedure
Escalation Contact
Recovery Notes
📊 Recovery Testing Metrics

Important metrics include:

Actual recovery time
Backup success rate
Restore success rate
Data integrity
Recovery failures
Recovery bottlenecks
Missing dependencies

These metrics help improve future recovery operations.

🧠 Disaster Recovery Principles
1. Prepare

Document recovery procedures before an incident.

2. Protect

Maintain secure and redundant backups.

3. Test

Regularly verify that backups can actually be restored.

4. Prioritize

Recover business-critical services first.

5. Document

Record recovery results and lessons learned.

6. Improve

Update the DR plan after every major test or incident.

🛠️ Example Infrastructure Recovery Architecture
                         Production Site
                               │
                    ┌──────────┴──────────┐
                    │                     │
                 Servers               Network
                    │                     │
                    └──────────┬──────────┘
                               │
                            Backup
                               │
                  ┌────────────┴────────────┐
                  │                         │
             Local Backup             Off-site Copy
                  │                         │
                  └────────────┬────────────┘
                               │
                         Recovery Site
                               │
                        Restored Services
🔍 Monitoring Backup Systems

Backup systems should also be monitored.

Monitor:

Backup job status
Backup age
Backup storage capacity
Failed jobs
Repository health
Restore test results

Example:

Backup Job
    │
    ├── SUCCESS → Continue
    │
    └── FAILED → ALERT

A silent backup failure can create a false sense of security.

🔐 Backup Access Control

Backup infrastructure should have separate access controls.

Recommended model:

IT Administrator
       │
       ▼
Production Access

Backup Administrator
       │
       ▼
Backup Infrastructure

Where possible, highly privileged backup administration should be isolated from normal daily user accounts.

🚧 Future Improvements

Planned work includes:

Proxmox Backup Server
Automated database backups
Network device configuration backups
Off-site backup replication
Immutable backup storage
Recovery testing automation
Disaster recovery runbooks
RPO/RTO documentation
Backup monitoring
Disaster recovery simulation
📝 Key Takeaways

A reliable backup strategy is built around:

Backup
  ↓
Verification
  ↓
Security
  ↓
Retention
  ↓
Restore Testing
  ↓
Disaster Recovery

The ultimate goal is not simply to have backups.

The goal is to ensure that critical services and data can be reliably recovered within an acceptable timeframe after an incident.

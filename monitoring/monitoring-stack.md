# Infrastructure Monitoring & Observability

## Overview

Infrastructure monitoring provides visibility into the health, availability, performance, and capacity of IT systems.

A proper monitoring strategy should provide early warning before infrastructure problems become service outages.

This document describes a practical monitoring architecture using concepts such as **SNMP, uptime monitoring, system metrics, network monitoring, alerting, dashboards, and incident response**.

---

## 🎯 Objectives

The monitoring architecture focuses on:

- Network monitoring
- Server monitoring
- Availability monitoring
- Resource monitoring
- SNMP
- Service monitoring
- Alerting
- Capacity planning
- Incident detection
- Performance analysis
- Infrastructure visibility

---

# 🏗️ Monitoring Architecture

A generalized monitoring architecture:

```text
                    IT Infrastructure
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
       Network           Servers          Services
       Devices            │                │
          │               │                │
          └───────────────┼────────────────┘
                          │
                          ▼
                    Monitoring Layer
                          │
             ┌────────────┼────────────┐
             │            │            │
             ▼            ▼            ▼
          Metrics       Alerts      Dashboards
             │            │            │
             └────────────┼────────────┘
                          ▼
                    IT Operations
📊 What Should Be Monitored?

Monitoring should cover multiple infrastructure layers.

Network
Routers
Switches
Access Points
Firewalls
WAN links
VPNs
Servers
CPU
Memory
Disk
Network
Load
Services
Applications
HTTP/HTTPS
APIs
Databases
Web applications
Critical business services
Infrastructure
Virtual machines
Containers
Storage
UPS
Environmental systems where available
🧭 Monitoring Categories

A useful monitoring model is:

Availability
    ↓
Performance
    ↓
Capacity
    ↓
Health
    ↓
Security
    ↓
Application

Each category provides different information.

🟢 Availability Monitoring

Availability monitoring answers:

Is the service or device reachable?

Examples:

Router → UP
Switch → UP
Server → UP
Website → UP
VPN → UP
Database → UP

Common techniques include:

ICMP
TCP connection tests
HTTP checks
HTTPS checks
DNS checks
Application-specific health checks
⏱️ Uptime Monitoring

Uptime monitoring can detect service outages.

Example:

Website
   │
   ▼
HTTP Check
   │
   ├── 200 OK → UP
   │
   └── Failure → ALERT

Monitoring should ideally verify more than simple ping availability.

A server can respond to ICMP while its actual application is unavailable.

📡 SNMP Monitoring

SNMP (Simple Network Management Protocol) is widely used for monitoring network infrastructure.

Typical SNMP-monitored devices include:

Routers
Switches
Firewalls
Access Points
UPS devices
Printers
Network appliances
🔄 SNMP Architecture
                    Monitoring Server
                           │
                           │ SNMP
                           ▼
                     ┌───────────┐
                     │   Router  │
                     └───────────┘
                           │
                           │
                    ┌───────────┐
                    │  Switch   │
                    └───────────┘

The monitoring system collects information from SNMP-enabled devices.

📈 SNMP Metrics

Depending on the device and MIB support, monitoring may include:

Interface traffic
Interface errors
CPU utilization
Memory utilization
Temperature
Device uptime
Packet statistics
Interface status
🔐 SNMP Security

SNMP versions differ in security capabilities.

Where supported, modern deployments should prefer secure SNMP configurations such as SNMPv3.

Security considerations include:

Strong authentication
Encryption where available
Restricted monitoring source addresses
Firewall controls
Avoiding unnecessary public exposure

SNMP should not be exposed directly to the public Internet.

🌐 Network Monitoring

Network monitoring provides visibility into infrastructure health.

Example:

                         WAN
                          │
                          ▼
                       Router
                          │
                    Core Switch
                 ┌────────┼────────┐
                 │        │        │
                 ▼        ▼        ▼
              Switch    Server     AP
                 │
                 ▼
              Clients

Each important network component should have an appropriate monitoring method.

🖥️ Server Monitoring

Server monitoring should track both infrastructure resources and services.

Typical metrics:

CPU
RAM
Disk
Network
Load
Processes
Services

Example:

Linux Server
    │
    ├── CPU
    ├── Memory
    ├── Disk
    ├── Network
    └── Services
💻 Virtualization Monitoring

Virtualization platforms require monitoring at multiple levels.

Physical Host
     │
     ├── CPU
     ├── RAM
     ├── Storage
     └── Network
           │
           ▼
        VM / LXC
           │
           ├── CPU
           ├── RAM
           ├── Disk
           └── Services

A guest problem may originate from the guest OS or from the underlying host/storage/network.

💾 Storage Monitoring

Storage monitoring is critical because capacity and health issues can cause widespread service failures.

Monitor:

Free capacity
Disk utilization
I/O
Latency
Filesystem health
RAID/ZFS health where applicable

Example:

Storage Capacity

0% ─────────────── 70% ───── 85% ───── 95% ─── 100%
                    │          │          │
                  Normal     Warning    Critical

Thresholds should be adjusted according to workload.

🌐 WAN Monitoring

WAN connectivity should be monitored separately from local network availability.

Example:

LAN
 │
 ▼
Router
 │
 ▼
ISP
 │
 ▼
Internet

Useful checks:

Gateway availability
Packet loss
Latency
Bandwidth utilization
Interface errors
Public endpoint reachability
📡 Latency Monitoring

Latency measures how long traffic takes to travel between endpoints.

Example:

Client
  │
  │ 10 ms
  ▼
Gateway
  │
  │ 25 ms
  ▼
ISP
  │
  │ 40 ms
  ▼
Destination

Increasing latency can indicate:

Congestion
Routing changes
Link problems
Infrastructure overload
📉 Packet Loss

Packet loss is another important network metric.

Example:

100 Packets Sent
      │
      ▼
97 Received
      │
      ▼
3% Packet Loss

Persistent packet loss should be investigated rather than simply increasing timeouts.

🚨 Alerting

Monitoring without alerting is incomplete.

An alerting pipeline can look like:

Metric
  ↓
Threshold / Condition
  ↓
Alert
  ↓
Notification
  ↓
Administrator
  ↓
Investigation
🔔 Alert Severity

A useful severity model:

Severity	Meaning
INFO	Informational event
WARNING	Potential problem
HIGH	Significant degradation
CRITICAL	Service outage / severe issue

Alert severity should reflect business impact rather than only technical metrics.

📢 Alert Examples

Potential alerts:

Server unreachable
CPU > threshold
RAM > threshold
Disk nearly full
WAN link down
Interface errors increasing
VPN unavailable
Website unavailable
Database unavailable
Storage degraded
🧠 Alert Fatigue

Too many alerts can become counterproductive.

A good monitoring system should avoid:

Minor Event
   ↓
Alert
   ↓
Alert
   ↓
Alert
   ↓
Alert
   ↓
Administrator ignores alerts

Instead:

Meaningful Event
      ↓
Relevant Alert
      ↓
Clear Action

Alerts should be actionable whenever possible.

📊 Dashboard Design

A useful infrastructure dashboard should provide quick visibility.

Example:

┌──────────────────────────────────────────┐
│          Infrastructure Overview         │
├──────────────┬──────────────┬────────────┤
│ Network      │ Servers      │ Services   │
│   HEALTHY    │   HEALTHY    │   HEALTHY  │
├──────────────┴──────────────┴────────────┤
│ WAN Traffic                               │
│ CPU / RAM                                │
│ Storage                                  │
│ Availability                             │
└──────────────────────────────────────────┘

Dashboards should prioritize information that requires action.

🧪 Uptime Kuma

Uptime monitoring platforms such as Uptime Kuma can be used to monitor:

HTTP
HTTPS
TCP
Ping
DNS
Docker containers
Other supported endpoints

A simplified architecture:

             Uptime Monitor
                   │
        ┌──────────┼──────────┐
        │          │          │
        ▼          ▼          ▼
      Website    Router     Server
        │          │          │
        ▼          ▼          ▼
       UP         UP         DOWN
                              │
                              ▼
                            ALERT
🌐 Application Monitoring

Infrastructure availability does not guarantee application availability.

Example:

Server → UP
Web Server → UP
Database → UP
Application → DOWN

Therefore, application-level health checks should be implemented where possible.

🩺 Health Checks

A health check may verify:

DNS Resolution
      ↓
TCP Connection
      ↓
HTTP Response
      ↓
Expected Status
      ↓
Expected Content

This provides stronger assurance than simply checking whether a server responds to ping.

📝 Monitoring Documentation

Each monitored asset should ideally have:

Field	Description
Asset	Device / Server
IP / Hostname	Identifier
Type	Router / Server / Service
Monitoring Method	SNMP / Ping / HTTP
Frequency	Check interval
Threshold	Alert condition
Severity	Alert level
Owner	Responsible team
Notes	Additional information
🔎 Incident Investigation

When an alert occurs:

Alert
 ↓
Confirm
 ↓
Identify Scope
 ↓
Check Dependencies
 ↓
Collect Logs
 ↓
Identify Root Cause
 ↓
Apply Fix
 ↓
Verify Recovery
 ↓
Document

Avoid immediately restarting systems without first collecting useful evidence.

📚 Root Cause Analysis

A monitoring platform helps identify symptoms, but root cause analysis requires correlation.

Example:

Website Down
     │
     ▼
Application Server
     │
     ▼
Disk Full
     │
     ▼
Log Growth
     │
     ▼
Log Rotation Failure

The actual root cause is not necessarily the first visible symptom.

📈 Capacity Planning

Monitoring historical metrics helps predict future requirements.

Examples:

CPU Usage
Memory Usage
Storage Growth
WAN Utilization
Database Size

A trend may look like:

Capacity
  │
  │                   /
  │                /
  │             /
  │          /
  │       /
  │_____/________________ Time

This enables proactive infrastructure planning.

🔐 Monitoring Security

Monitoring systems themselves are sensitive infrastructure.

Protect them using:

Strong authentication
Restricted management access
HTTPS
Secure SNMP
Firewall policies
Regular updates
Backup
Access logging

Monitoring credentials should never be stored in public repositories.

🧭 Observability

Monitoring generally answers:

Is something working?

Observability goes deeper and helps answer:

Why is it behaving this way?

A broader observability model includes:

Metrics
   +
Logs
   +
Traces
   +
Events
   ↓
Observability

For infrastructure operations, combining metrics and logs can significantly improve troubleshooting.

🛠️ Recommended Monitoring Stack

A small infrastructure environment can use multiple tools for different purposes:

                    Infrastructure
                          │
          ┌───────────────┼───────────────┐
          │               │               │
          ▼               ▼               ▼
        Network         Servers        Services
          │               │               │
          ▼               ▼               ▼
       SNMP /          System          HTTP/TCP
       Network         Metrics          Checks
          │               │               │
          └───────────────┼───────────────┘
                          ▼
                    Monitoring Layer
                          │
                    ┌─────┴─────┐
                    ▼           ▼
                Dashboard      Alerts

The exact toolset should depend on scale, operational requirements, and existing infrastructure.

🚧 Future Improvements

Planned monitoring work includes:

LibreNMS deployment
SNMPv3
Uptime monitoring
Centralized dashboards
Alert routing
Email notifications
Network traffic analysis
Server monitoring
Proxmox monitoring
Storage monitoring
Log aggregation
SIEM integration
Capacity forecasting
📝 Key Takeaways

Effective monitoring provides visibility across the complete infrastructure stack:

Network
  ↓
Servers
  ↓
Virtualization
  ↓
Storage
  ↓
Services
  ↓
Applications
  ↓
Users

A mature monitoring strategy should not only detect outages.

It should help the infrastructure team:

Detect problems early
Understand performance
Identify root causes
Plan capacity
Reduce downtime
Improve reliability
Support incident response

# Routing & Network Path Troubleshooting

## Overview

Routing determines how packets move between different networks.

A reliable routing design is essential for communication between users, servers, remote networks, VPNs, and the Internet.

This document covers fundamental routing concepts, static routes, default routes, route selection, MikroTik routing, and a structured approach to troubleshooting connectivity problems.

The examples use private laboratory addressing and do not represent any production network.

---

## 🎯 Objectives

This lab focuses on:

* Understanding IPv4 routing
* Designing static routes
* Understanding default routes
* Understanding connected routes
* Troubleshooting gateway connectivity
* Understanding routing tables
* Diagnosing asymmetric routing
* Troubleshooting VPN routes
* Using network diagnostic tools
* Understanding the relationship between ARP, routing, NAT, and firewall policies

---

# 🧭 What Is Routing?

Routing is the process of determining where a packet should be sent based on its destination IP address.

Example:

```text id="j4g5vl"
Client
192.168.30.100
      │
      ▼
Gateway
192.168.30.1
      │
      ▼
Router
      │
      ▼
Internet
```

The router examines the destination IP address and selects an appropriate route.

---

# 📋 Routing Table

A routing table contains information used by the router to determine where packets should go.

A simplified routing table might look like:

```text id="e6g8g3"
Destination        Gateway          Interface

192.168.10.0/24    connected        LAN
192.168.20.0/24    connected        SERVER
10.10.10.0/24      192.168.10.2     LAN
0.0.0.0/0          ISP Gateway      WAN
```

---

# 🏠 Connected Routes

When an interface is configured with an IP address and subnet mask, the router normally knows the directly connected network.

Example:

```text id="w4v3x1"
Interface IP:
192.168.10.1/24

Connected Network:
192.168.10.0/24
```

The router knows that hosts within `192.168.10.0/24` are directly reachable through that interface.

---

# 🌐 Default Route

A default route is used when no more specific route exists.

The IPv4 default route is:

```text id="3n0q3d"
0.0.0.0/0
```

Example:

```text id="g8v0k3"
0.0.0.0/0
      │
      ▼
ISP Gateway
      │
      ▼
Internet
```

This is commonly used for Internet-bound traffic.

---

# 🛣️ Static Routing

A static route is manually configured by an administrator.

Example:

```text id="g6xv5s"
Destination:
10.10.20.0/24

Gateway:
192.168.10.2
```

Conceptually:

```text id="9e0h7m"
Local Network
192.168.10.0/24
       │
       ▼
Router A
       │
       │ 192.168.10.2
       ▼
Router B
       │
       ▼
10.10.20.0/24
```

Static routes are useful for:

* Small networks
* Lab environments
* Specific remote networks
* VPN routing
* Backup paths
* Controlled infrastructure paths

---

# 🔄 Dynamic Routing

Dynamic routing protocols allow routers to exchange routing information automatically.

Examples include:

* OSPF
* BGP
* RIP
* IS-IS

For small environments, static routing may be sufficient.

For larger or more complex networks, dynamic routing can improve scalability and reduce manual configuration.

---

# 🧠 Route Selection

When multiple routes match a destination, the router generally prefers the most specific route.

For example:

```text id="n9v9iz"
10.0.0.0/8
10.10.0.0/16
10.10.20.0/24
```

For destination:

```text id="2h8z6u"
10.10.20.50
```

The `/24` route is more specific than `/16` or `/8`.

This concept is commonly called **longest prefix match**.

---

# ⚙️ Administrative Distance

When multiple routing sources provide routes to the same destination, routing systems may use administrative preference mechanisms to determine which route should be trusted.

In RouterOS, route selection involves several attributes and routing mechanisms.

The exact behavior should always be verified against the RouterOS version and routing configuration being used.

---

# 📡 Routing vs ARP

Routing and ARP solve different problems.

### ARP

ARP resolves:

```text id="0g5dki"
IPv4 Address
      ↓
MAC Address
```

Example:

```text id="s7o2fy"
192.168.10.1
      ↓
AA:BB:CC:DD:EE:FF
```

### Routing

Routing determines:

```text id="j6p4w2"
Destination Network
      ↓
Next Hop / Interface
```

Both may be involved in successful local or routed communication.

---

# 🔍 Gateway Troubleshooting

One common infrastructure problem is:

> Client has a valid IP address, but cannot ping the gateway.

A structured troubleshooting process is important.

---

## Step 1 — Check Physical Connectivity

Verify:

* Ethernet cable
* Switch port
* Link status
* NIC status
* Wi-Fi association
* Interface status

---

## Step 2 — Check IP Configuration

### Windows

```powershell id="e3z6u0"
ipconfig /all
```

### Linux

```bash id="x8q9x2"
ip addr
ip route
```

Verify:

```text id="m7g8f4"
IP Address
Subnet Mask
Default Gateway
DNS
```

---

## Step 3 — Verify Subnet

Example:

```text id="e7zj55"
Client:
192.168.10.100/24

Gateway:
192.168.10.1/24
```

Both belong to:

```text
192.168.10.0/24
```

Therefore, the client should be able to communicate with the gateway at Layer 2, assuming there are no other issues.

---

# 🔎 Step 4 — Check ARP

Windows:

```powershell id="b1p0kj"
arp -a
```

Linux:

```bash id="5n4m5m"
ip neigh
```

If the gateway IP does not have a corresponding MAC address, investigate:

* VLAN configuration
* Switch port
* Wrong subnet
* Duplicate IP
* Interface state
* Layer 2 connectivity
* ARP filtering/security features

---

# 📡 Step 5 — Ping the Gateway

```bash id="3r5x2w"
ping 192.168.10.1
```

If the gateway does not respond:

```text id="5zq6j8"
Physical Layer
      ↓
Layer 2
      ↓
IP Configuration
      ↓
ARP
      ↓
Gateway Interface
      ↓
Firewall
```

Investigate each layer systematically.

---

# 🌐 Step 6 — Test an External IP

If the gateway works:

```bash id="o0j4qm"
ping 8.8.8.8
```

If the external IP works but a domain name does not:

```text id="0qk1cy"
Client
  ↓
Gateway        ✓
  ↓
Internet IP    ✓
  ↓
DNS            ✗
```

The problem may be DNS rather than routing.

---

# 🔤 Step 7 — Test DNS

Windows:

```powershell id="jjg2ka"
nslookup example.com
```

Linux:

```bash id="u4b0nd"
dig example.com
```

Also verify the configured DNS servers.

---

# 🧭 Traceroute

Traceroute helps identify where packets stop progressing.

### Windows

```powershell id="5p8z2q"
tracert 8.8.8.8
```

### Linux

```bash id="n3z5jb"
traceroute 8.8.8.8
```

A simplified path may look like:

```text id="s6zq4y"
Client
  ↓
Gateway
  ↓
ISP Router
  ↓
Transit Router
  ↓
Destination
```

---

# 🛠️ MikroTik Routing

RouterOS provides routing information through its routing subsystem.

The routing table can be inspected through:

```text id="9c7w8a"
WinBox
  ↓
IP
  ↓
Routes
```

Or through the RouterOS terminal using appropriate routing commands for the installed RouterOS version.

---

# 📋 Useful MikroTik Checks

When troubleshooting routing, review:

```text id="1m0e4q"
Interface status
IP addresses
Routing table
ARP table
Firewall rules
NAT rules
Connection tracking
DNS configuration
```

The exact command syntax should match the RouterOS version in use.

---

# 🔥 Firewall vs Routing

A common troubleshooting mistake is assuming every connectivity problem is a routing problem.

Consider:

```text id="m0k3v4"
Client
  │
  ▼
Gateway
  │
  ▼
Routing
  │
  ▼
Firewall
  │
  ▼
NAT
  │
  ▼
Internet
```

A correct route does not guarantee that traffic will be allowed.

Likewise, an allow rule does not create a route.

Routing and firewall policy must work together.

---

# 🔄 NAT vs Routing

Routing decides:

> **Where should the packet go?**

NAT modifies:

> **Which source/destination address or port is represented in the packet?**

Example:

```text id="x9p3ra"
Private Client
192.168.30.100
       │
       ▼
MikroTik
       │
       │ NAT
       ▼
Public IP
       │
       ▼
Internet
```

NAT is therefore not a replacement for routing.

---

# 🔁 Asymmetric Routing

Asymmetric routing occurs when traffic travels through different paths in each direction.

Example:

```text id="0d4p1z"
Outbound:
Client → Router A → ISP A → Internet

Inbound:
Internet → ISP B → Router B → Client
```

This can create problems with:

* Stateful firewalls
* NAT
* Connection tracking
* VPNs
* Security appliances

When diagnosing unusual connectivity issues, return-path routing should be considered.

---

# 🔐 VPN Routing

VPN connectivity often depends on correct routes.

Example:

```text id="p4c7zx"
Remote Client
     │
     ▼
WireGuard
     │
     ▼
VPN Network
     │
     ▼
Internal Network
```

A VPN can be successfully established while internal resources remain unreachable if the required routes are missing.

Therefore, VPN troubleshooting should verify:

```text id="c8g2rx"
VPN Handshake
      ↓
VPN IP Address
      ↓
Routes
      ↓
Firewall
      ↓
NAT
      ↓
Destination
```

---

# 🧪 Troubleshooting Decision Tree

```text id="y3m4x0"
Cannot Reach Destination
        │
        ▼
Is Interface Up?
        │
   ┌────┴────┐
   No        Yes
   │          │
Fix Link      ▼
          Valid IP?
              │
         ┌────┴────┐
         No        Yes
         │          │
      Fix IP        ▼
                 Gateway?
                    │
               ┌────┴────┐
               No        Yes
               │          │
          Check ARP       ▼
                     Route Exists?
                         │
                    ┌────┴────┐
                    No        Yes
                    │          │
                Add/Fix Route  ▼
                             Firewall?
                                │
                           ┌────┴────┐
                           Block     Allow
                             │         │
                           Fix      Continue
```

---

# 📊 Routing Documentation

A production-quality routing document should contain:

| Field               | Description                  |
| ------------------- | ---------------------------- |
| Destination         | Destination network          |
| Prefix              | Network prefix               |
| Gateway             | Next-hop address             |
| Interface           | Exit interface               |
| Route Type          | Connected / Static / Dynamic |
| Metric / Preference | Route preference             |
| Purpose             | Why the route exists         |
| Status              | Active / Disabled            |
| Notes               | Additional information       |

---

# 🔒 Security Considerations

Routing should also be reviewed from a security perspective.

Recommended practices include:

* Do not create unnecessary routes
* Restrict access between sensitive networks
* Review VPN routes
* Monitor unexpected routing changes
* Protect routing infrastructure
* Use appropriate firewall policies
* Document all static routes
* Remove obsolete routes
* Back up router configuration

---

# 🚧 Future Improvements

Planned lab work includes:

* OSPF
* Policy routing
* Multiple WAN routing
* Failover
* ECMP
* Routing marks
* Advanced WireGuard routing
* IPv6 routing
* Dynamic routing troubleshooting
* Automated route monitoring

---

## 📝 Key Takeaways

Effective routing management requires understanding the complete network path:

```text id="v2t9ra"
Source
  ↓
Layer 2
  ↓
IP Configuration
  ↓
ARP
  ↓
Gateway
  ↓
Routing
  ↓
Firewall
  ↓
NAT
  ↓
Destination
```

A structured troubleshooting methodology is more effective than changing configuration randomly.

The objective is to identify the exact layer where communication fails, apply the smallest appropriate correction, verify the result, and document the solution.

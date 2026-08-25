# VPN & WireGuard Network Design

## Overview

A Virtual Private Network (VPN) provides a secure communication channel across an untrusted network such as the public Internet.

This laboratory focuses on **WireGuard-based VPN architecture**, with emphasis on secure remote access, routing, firewall policy, NAT considerations, troubleshooting, and infrastructure security.

The examples use laboratory addressing and do not contain real production IP addresses, credentials, private keys, or confidential configuration.

---

## 🎯 Objectives

This lab focuses on:

* Understanding VPN architecture
* Understanding WireGuard fundamentals
* Secure remote administration
* Peer-based VPN configuration
* VPN addressing
* Routing through a VPN
* Firewall integration
* NAT considerations
* Connection troubleshooting
* Secure key management
* Remote infrastructure access

---

# 🔐 What Is a VPN?

A VPN creates an encrypted communication tunnel between two or more endpoints.

A simplified architecture:

```text id="v8k3tq"
Remote User
     │
     │ Encrypted Tunnel
     ▼
  Internet
     │
     ▼
VPN Gateway
     │
     ▼
Internal Network
```

The Internet acts as the transport network while the VPN provides a protected logical communication path.

---

# ⚡ Why WireGuard?

WireGuard is a modern VPN protocol designed around a relatively small and straightforward cryptographic and configuration model.

Key characteristics include:

* Public/private key authentication
* Modern cryptography
* Lightweight protocol design
* Peer-based configuration
* Simple tunnel addressing
* Support across multiple operating systems and network platforms

WireGuard is useful for:

* Remote administration
* Site-to-site connectivity
* Infrastructure management
* Secure access to internal services
* Lab environments

---

# 🏗️ Basic WireGuard Architecture

A basic remote-access architecture:

```text id="8x0h3b"
                    INTERNET
                       │
                       │
                ┌──────▼──────┐
                │   Remote    │
                │   Client    │
                └──────┬──────┘
                       │
                 WireGuard VPN
                       │
                       ▼
                ┌─────────────┐
                │   Router /  │
                │ VPN Gateway │
                └──────┬──────┘
                       │
                       ▼
                Internal Network
```

The VPN gateway terminates the encrypted tunnel and controls access to internal resources.

---

# 🔑 WireGuard Key Model

WireGuard uses public/private key pairs.

Each peer has:

```text id="j9s7c1"
Private Key
     +
Public Key
```

The private key must remain secret.

The public key can be shared with the corresponding peer.

A simplified relationship:

```text id="m8v2ya"
Peer A
Private Key A
Public Key A
      │
      │
      ▼
Peer B
Public Key A

Peer B
Private Key B
Public Key B
      │
      │
      ▼
Peer A
Public Key B
```

---

# 🚨 Private Key Security

Private keys should **never** be committed to a public GitHub repository.

Never upload:

```text
privatekey
server_private.key
client_private.key
wg0.conf
```

if those files contain real credentials or private keys.

For documentation, use placeholders:

```text id="x5m0s9"
<SERVER_PRIVATE_KEY>
<CLIENT_PRIVATE_KEY>
<SERVER_PUBLIC_KEY>
```

---

# 🌐 VPN Addressing

A dedicated VPN subnet should be used.

Example:

```text id="x9h3q4"
VPN Network:
10.99.0.0/24
```

Example allocation:

```text id="6u0f6h"
VPN Gateway:
10.99.0.1

Client 01:
10.99.0.2

Client 02:
10.99.0.3

Client 03:
10.99.0.4
```

The VPN subnet should not conflict with existing local or remote networks.

---

# 🧭 Routing

Establishing a WireGuard tunnel does not automatically mean that all internal networks are reachable.

Routing must be designed intentionally.

Example:

```text id="1t7p1z"
Remote Client
10.99.0.2
      │
      ▼
WireGuard
      │
      ▼
VPN Gateway
10.99.0.1
      │
      ▼
Internal Network
192.168.20.0/24
```

The client must have a route or appropriate `AllowedIPs` configuration for the destination network.

---

# 📌 AllowedIPs

`AllowedIPs` is one of the most important WireGuard configuration concepts.

It can influence:

* Which traffic is sent through a peer
* Which IP addresses are associated with a peer
* Routing behavior

For example, a client intended to access only an internal network might use a configuration conceptually similar to:

```text id="u3p4z8"
AllowedIPs = 192.168.20.0/24
```

A full-tunnel design may instead route broader traffic through the VPN, such as:

```text id="4j5w7k"
AllowedIPs = 0.0.0.0/0
```

Full-tunnel configurations require additional consideration for:

* DNS
* Internet routing
* NAT
* MTU
* Performance
* Security policy

---

# 🔥 VPN Firewall Integration

The VPN interface itself must be considered in firewall policy.

A simplified traffic path:

```text id="1a7g8f"
Remote Client
      │
      ▼
Internet
      │
      ▼
WAN Firewall
      │
      ▼
WireGuard
      │
      ▼
Forward Firewall
      │
      ▼
Internal Resource
```

A successful VPN handshake does not necessarily mean that internal traffic is permitted.

The firewall must allow only the required VPN-to-network communication.

---

# 🔐 Least-Privilege VPN Access

Not every VPN user should automatically have unrestricted access to the entire internal network.

For example:

```text id="y5v8x3"
VPN Client
    │
    ├── Monitoring Server → ALLOW
    ├── Management Network → ALLOW
    ├── Database Network → DENY
    └── CCTV Network → DENY
```

Access should be based on:

* User role
* Operational requirement
* Destination
* Protocol
* Port
* Security policy

---

# 🌍 Site-to-Site VPN

WireGuard can also connect two networks.

Example:

```text id="5f4m8r"
Site A                              Site B

192.168.10.0/24                  192.168.20.0/24
      │                                │
      ▼                                ▼
 Router A ===== WireGuard ===== Router B
```

Traffic between the networks can then be routed through the encrypted tunnel.

---

# 🔄 Site-to-Site Routing

Example:

```text id="7z0c4y"
192.168.10.0/24
      │
      ▼
Router A
      │
      │ WireGuard
      ▼
Router B
      │
      ▼
192.168.20.0/24
```

Required routing must exist in both directions.

If Site A can reach Site B but Site B cannot return traffic to Site A, investigate the return route.

---

# 🧱 NAT Considerations

NAT and VPN routing should not be confused.

Routing determines the path.

NAT modifies packet addressing.

For a site-to-site VPN, unnecessary NAT between the VPN-connected networks may make troubleshooting and access-control policies more complicated.

A preferred design is often to route the networks directly where possible, while applying NAT only where it is actually required.

---

# 📡 Endpoint Behind NAT

WireGuard can operate when a peer is behind NAT, depending on the network conditions and configuration.

For peers that may become unreachable after periods of inactivity, a persistent keepalive may be useful in some scenarios.

Example concept:

```text id="k2h9m5"
PersistentKeepalive = 25
```

The appropriate value depends on the network environment and should not be enabled blindly for every peer.

---

# 🧪 WireGuard Connectivity Workflow

When troubleshooting a VPN:

```text id="2c6g5s"
Check Endpoint
      ↓
Check UDP Reachability
      ↓
Check Handshake
      ↓
Check Tunnel IP
      ↓
Check AllowedIPs
      ↓
Check Routes
      ↓
Check Firewall
      ↓
Check NAT
      ↓
Test Destination
```

---

# 🔎 Handshake Troubleshooting

If a WireGuard peer does not establish a handshake, investigate:

* Endpoint address
* UDP port
* Firewall
* NAT
* Public key
* Private key
* Peer configuration
* System time
* Internet connectivity

A successful handshake indicates that the cryptographic tunnel is established, but it does not prove that application traffic can reach the destination.

---

# 📊 Traffic Troubleshooting

If handshake works but internal resources cannot be reached:

```text id="q4u2x8"
Handshake
    ✓
     │
     ▼
Tunnel IP
    ?
     │
     ▼
AllowedIPs
    ?
     │
     ▼
Routing
    ?
     │
     ▼
Firewall
    ?
     │
     ▼
NAT
    ?
     │
     ▼
Destination
    ?
```

This distinction is extremely useful when troubleshooting real VPN environments.

---

# 🧰 Useful Diagnostic Tools

### Windows

```powershell id="h0x7k6"
ipconfig
route print
ping <vpn-ip>
tracert <destination>
```

### Linux

```bash id="j3s8b2"
ip addr
ip route
ip rule
ip neigh
ping <vpn-ip>
traceroute <destination>
```

### MikroTik

Review:

```text id="r6d0v1"
WireGuard interface
Peer configuration
Latest handshake
Allowed addresses
Routing table
Firewall
NAT
Connection tracking
Interface traffic
```

---

# 🛡️ Security Best Practices

Recommended practices include:

### 1. Protect Private Keys

Never share private keys.

### 2. Use Unique Keys

Each peer should have its own key pair.

### 3. Restrict AllowedIPs

Only route the networks a peer actually needs.

### 4. Restrict Firewall Access

VPN access should not automatically equal unrestricted internal access.

### 5. Remove Unused Peers

Disable or remove peers that are no longer required.

### 6. Monitor VPN Activity

Review:

* Handshake times
* Traffic volume
* Unexpected peers
* Configuration changes

### 7. Protect Management Access

Prefer VPN-based administration rather than exposing management services directly to the Internet.

---

# 🔄 Remote Administration Architecture

A secure administrative model can look like:

```text id="4r1p0c"
Administrator
      │
      ▼
Internet
      │
      ▼
WireGuard VPN
      │
      ▼
Management Network
      │
      ├── MikroTik
      ├── Switches
      ├── Servers
      ├── Proxmox
      └── Monitoring
```

This reduces the number of management services that need to be publicly exposed.

---

# 🧠 VPN Design Principles

A good VPN architecture should be:

* Secure
* Minimal
* Documented
* Role-based
* Routable
* Monitored
* Easy to troubleshoot
* Scalable

The VPN should provide access to required resources—not automatically provide unrestricted network access.

---

# 🚧 Future Improvements

Planned laboratory work includes:

* MikroTik WireGuard site-to-site VPN
* Remote-access VPN
* Multiple WireGuard peers
* VPN-based infrastructure management
* VPN monitoring
* Automated peer management
* VPN logging
* Advanced routing
* IPv6 VPN concepts
* Multi-site connectivity

---

## 📝 Key Takeaways

A VPN deployment consists of more than simply establishing an encrypted tunnel.

A complete VPN design must consider:

```text id="k8t4j3"
Keys
 ↓
Endpoint
 ↓
Handshake
 ↓
Tunnel Addressing
 ↓
AllowedIPs
 ↓
Routing
 ↓
Firewall
 ↓
NAT
 ↓
Application Access
 ↓
Monitoring
```

A successful handshake is only the beginning. Secure and reliable VPN connectivity requires correct routing, firewall policy, addressing, and access control.

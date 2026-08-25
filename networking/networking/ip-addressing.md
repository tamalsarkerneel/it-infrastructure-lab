# IP Addressing & Network Design

## Overview

A well-planned IP addressing scheme is a fundamental component of reliable and manageable network infrastructure.

This document describes the principles used in this laboratory for designing IPv4 addressing, subnet allocation, gateway configuration, DHCP, static addressing, and network documentation.

The examples are based on private IPv4 addressing and do not represent any production organization's actual network.

---

## 🌐 Private IPv4 Addressing

The laboratory uses RFC 1918 private IPv4 address ranges.

Common private ranges include:

| Range            | CIDR  | Typical Usage             |
| ---------------- | ----- | ------------------------- |
| `10.0.0.0/8`     | `/8`  | Large enterprise networks |
| `172.16.0.0/12`  | `/12` | Medium-sized networks     |
| `192.168.0.0/16` | `/16` | Small networks / labs     |

For laboratory environments, `10.0.0.0/8` and `192.168.0.0/16` can be used depending on the required scale.

---

## 🧮 Subnetting

Subnetting allows a larger network to be divided into smaller logical networks.

For example:

```text
Network: 192.168.10.0/24

Network Address:     192.168.10.0
Usable Range:        192.168.10.1 - 192.168.10.254
Broadcast Address:   192.168.10.255
Subnet Mask:         255.255.255.0
Usable Hosts:        254
```

Subnetting provides better organization and makes network management easier.

---

## 🏗️ Example Network Design

A generalized infrastructure network may use the following logical structure:

| Network           | Purpose                | Example Gateway |
| ----------------- | ---------------------- | --------------- |
| `192.168.10.0/24` | Network Infrastructure | `192.168.10.1`  |
| `192.168.20.0/24` | Servers                | `192.168.20.1`  |
| `192.168.30.0/24` | Staff Clients          | `192.168.30.1`  |
| `192.168.40.0/24` | Guest Network          | `192.168.40.1`  |
| `192.168.50.0/24` | CCTV / IoT             | `192.168.50.1`  |
| `192.168.60.0/24` | Management             | `192.168.60.1`  |

> These are example laboratory networks and should not be interpreted as a real production configuration.

---

## 📋 Address Allocation Strategy

A consistent addressing strategy makes troubleshooting and administration easier.

### Infrastructure Devices

Static IP addresses can be assigned to:

* Routers
* Core switches
* Access points
* Network controllers
* NVRs
* Monitoring systems
* Management interfaces

Example:

```text
Router       → 192.168.10.1
Core Switch  → 192.168.10.2
AP Controller → 192.168.10.10
Monitoring   → 192.168.10.20
```

---

## 🖥️ Server Addressing

Critical servers should normally use predictable addressing.

Example:

```text
192.168.20.10 → Domain Controller
192.168.20.20 → Application Server
192.168.20.30 → Database Server
192.168.20.40 → Monitoring Server
192.168.20.50 → Backup Server
```

The actual addressing scheme should be documented and maintained centrally.

---

## 👥 Client Addressing

End-user devices can normally receive addresses through DHCP.

Example:

```text
DHCP Network
192.168.30.0/24

Gateway:
192.168.30.1

DHCP Pool:
192.168.30.100 - 192.168.30.240

Reserved:
192.168.30.2 - 192.168.30.99
```

Reserved addresses can be used for devices that require predictable IP assignments.

---

## 🌐 DHCP Design

A DHCP scope should define:

```text
Network
Subnet Mask
Default Gateway
DNS Servers
Lease Duration
Address Pool
Excluded Addresses
Reservations
```

Example:

```text
Network:        192.168.30.0/24
Gateway:        192.168.30.1
Pool Start:     192.168.30.100
Pool End:       192.168.30.240
DNS:            192.168.20.10
Lease:          8 Hours
```

---

## 🧭 Default Gateway

The default gateway provides a path from the local network to other networks.

Example:

```text
Client
192.168.30.101
      │
      ▼
Gateway
192.168.30.1
      │
      ▼
Router / Firewall
      │
      ▼
Internet / Other Networks
```

---

## 🔎 DNS

DNS translates hostnames into IP addresses.

For example:

```text
server01.example.local
        ↓
192.168.20.10
```

Infrastructure environments should use a consistent DNS strategy.

DNS records commonly include:

* A
* AAAA
* CNAME
* MX
* PTR
* TXT

---

## 🔐 Network Segmentation

Logical network segmentation can help isolate different categories of devices.

Example:

```text
                    ROUTER / FIREWALL
                           │
             ┌─────────────┼─────────────┐
             │             │             │
          Servers        Users         Guests
             │             │             │
          Network        Network       Network
```

Segmentation can reduce unnecessary communication between systems and improve security.

However, segmentation should be implemented according to the capabilities and requirements of the actual network infrastructure.

---

## 📡 Static vs DHCP

### Static IP

Recommended for systems such as:

* Routers
* Switches
* Servers
* NVRs
* Network controllers
* Monitoring systems

### DHCP

Suitable for:

* Workstations
* Laptops
* Mobile devices
* Guest devices
* Temporary systems

---

## 🧪 Troubleshooting Workflow

When investigating an IP connectivity problem:

```text
1. Check physical connectivity
        ↓
2. Check IP address
        ↓
3. Check subnet mask
        ↓
4. Check default gateway
        ↓
5. Check ARP
        ↓
6. Ping gateway
        ↓
7. Ping another local device
        ↓
8. Test DNS resolution
        ↓
9. Test external connectivity
        ↓
10. Check routing/firewall
```

Useful commands include:

### Windows

```powershell
ipconfig /all
ping <gateway>
arp -a
tracert <destination>
nslookup <hostname>
route print
```

### Linux

```bash
ip addr
ip route
ip neigh
ping <gateway>
traceroute <destination>
dig <hostname>
```

---

## 🔍 ARP Troubleshooting

ARP maps IPv4 addresses to MAC addresses within a local network.

Example:

```text
IP Address       MAC Address
192.168.10.1     XX:XX:XX:XX:XX:XX
```

If a client cannot reach its gateway, checking the ARP table can help determine whether the client has successfully resolved the gateway's MAC address.

---

## 🔒 Security Considerations

IP addressing should be designed with security in mind.

Recommended practices include:

* Avoid exposing private addressing directly to the Internet
* Restrict management interfaces
* Separate guest and sensitive networks where appropriate
* Use firewall rules between logical networks
* Disable unnecessary services
* Monitor unusual traffic
* Maintain accurate network documentation
* Review unused IP addresses and devices periodically

---

## 📚 Documentation

A network should maintain an up-to-date IP address inventory containing:

```text
Device Name
Device Type
IP Address
MAC Address
Subnet
Gateway
DNS
Location
Owner / Department
Purpose
Status
```

This information can eventually be maintained using an IPAM platform such as NetBox or another suitable network documentation system.

---

## 🚧 Future Improvements

Planned improvements for this laboratory include:

* IPv6 addressing
* VLAN-based segmentation
* DHCP reservations
* DNS infrastructure
* IP Address Management
* Network automation
* Configuration backups
* Automated network discovery
* Infrastructure monitoring

---

## 📝 Key Takeaways

A good IP addressing strategy should be:

* Consistent
* Documented
* Scalable
* Easy to troubleshoot
* Security-conscious
* Suitable for future expansion

IP addressing is not simply about assigning IP addresses; it is an important part of overall network architecture and infrastructure management.

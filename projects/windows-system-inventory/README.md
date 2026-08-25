# Windows System Inventory

A PowerShell-based Windows infrastructure inventory tool designed to collect essential hardware, operating system, network, disk, service, port, and update information from Windows systems.

---

## 📌 Overview

Maintaining an accurate infrastructure inventory is an important part of IT operations.

Manual inventory collection can be time-consuming and may result in inconsistent or outdated information.

This project automates the collection of common Windows system information using PowerShell and Windows Management Instrumentation / CIM.

---

## 🎯 Objectives

The project aims to:

- Automate Windows system inventory
- Collect hardware information
- Collect operating system information
- Identify storage capacity and utilization
- Collect network configuration
- Identify network adapters
- Count running services
- Identify listening TCP ports
- Review recently installed Windows updates

---

## 🛠️ Technologies

| Technology | Purpose |
|---|---|
| PowerShell | Automation |
| Windows | Target operating system |
| CIM | Hardware and OS information |
| Get-NetAdapter | Network adapter inventory |
| Get-NetIPConfiguration | IP configuration |
| Get-NetTCPConnection | Listening port detection |
| Get-HotFix | Windows update information |

---

## 📁 Project Structure

```text
windows-system-inventory/
│
├── system-inventory.ps1
└── README.md
🚀 Requirements
Windows 10 / Windows 11
Windows Server 2016 or later
PowerShell 5.1+
Administrator privileges recommended
▶️ Usage

Clone the repository:

git clone <repository-url>

Navigate to the project:

cd windows-system-inventory

If PowerShell execution policy prevents script execution, review the current policy:

Get-ExecutionPolicy

Run the script:

.\system-inventory.ps1

If administrative privileges are required, open PowerShell as Administrator and run the script again.

📊 Information Collected
System Information

The script collects:

Computer name
Operating system
OS version
Architecture
Manufacturer
Model
Domain
CPU Information

The script collects:

CPU name
Physical CPU cores
Logical processors
Maximum clock speed

Example:

CPU               : Intel(R) Core(TM)
Cores             : 4
Logical Processors: 8
Max Clock Speed   : 3200 MHz
Memory Information

The script reports total physical memory installed on the system.

Example:

Total RAM : 16 GB
Disk Information

The script identifies local disks and reports:

Drive letter
Total capacity
Free space
Used percentage

Example:

DeviceID   Size(GB)   Free(GB)   Used(%)

C:         476.84     210.32     55.9
D:         931.51     700.21     24.8
Network Information

The script collects:

Network interface
IPv4 address
Default gateway
DNS servers

This provides a quick overview of the system's network configuration.

Network Adapter Information

The script reports:

Adapter name
Interface description
Connection status
Link speed

Example:

Name        Status    LinkSpeed
Ethernet    Up        1 Gbps
Wi-Fi       Disconnected
Running Services

The script counts currently running Windows services.

Example:

Running Services : 145

This provides a quick operational overview.

Listening TCP Ports

The script identifies TCP ports currently listening on the system.

This can help with:

Troubleshooting
Service discovery
Security reviews
Attack surface analysis

Example:

LocalAddress   LocalPort
0.0.0.0        80
0.0.0.0        443
0.0.0.0        3389

Unexpected listening ports should be investigated.

Windows Updates

The script displays recently installed Windows hotfixes.

Information includes:

Hotfix ID
Description
Installation date

This can provide a quick view of recent patch activity.

🔐 Security Considerations

The script is designed primarily as a read-only inventory tool.

It does not intentionally:

Modify system configuration
Create users
Delete files
Change firewall rules
Stop services
Install software
Change permissions

However, system inventory can reveal sensitive infrastructure information.

The output should therefore be treated as administrative information and should not be publicly shared if it contains real internal network details.

🧪 Example Use Cases

This tool can be useful for:

IT Asset Inventory

Collect basic hardware and OS information from Windows systems.

Troubleshooting

Quickly identify:

IP configuration
Disk capacity
Network adapters
Running services
Listening ports
Security Review

Identify exposed services and listening ports.

Infrastructure Documentation

Generate consistent system information for infrastructure records.

Pre-Migration Assessment

Collect system specifications before:

Server migration
Hardware replacement
OS upgrade
Virtualization
🔄 Workflow
Windows System
      │
      ▼
PowerShell Script
      │
      ├── System Information
      ├── CPU
      ├── Memory
      ├── Disk
      ├── Network
      ├── Services
      ├── Ports
      └── Updates
            │
            ▼
       Inventory Output
🔧 Future Improvements

Planned improvements include:

Export to CSV
Export to JSON
HTML report generation
Automatic inventory database
Remote computer inventory
Active Directory integration
Software inventory
Installed application inventory
Windows Defender status
Firewall profile status
Disk health information
CPU utilization
Memory utilization
Scheduled inventory collection
Centralized asset management integration
📚 Learning Outcomes

This project demonstrates practical knowledge of:

PowerShell
Windows administration
CIM / WMI
Hardware inventory
Network administration
Service management
Port discovery
Patch management
Infrastructure documentation
System administration automation
👨‍💻 Author

Tamal Sarker

IT Infrastructure | System Administration | Networking | Automation

GitHub:

https://github.com/tamalsarkerneel

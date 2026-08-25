# ==========================================
# Windows System Inventory
# Author: Tamal Sarker
# Version: 1.0
# ==========================================

$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$ComputerName = $env:COMPUTERNAME

Write-Host "=========================================="
Write-Host "       WINDOWS SYSTEM INVENTORY"
Write-Host "=========================================="
Write-Host "Computer : $ComputerName"
Write-Host "Date     : $Date"
Write-Host "=========================================="

Write-Host ""
Write-Host "[SYSTEM INFORMATION]"
Write-Host "------------------------------------------"

$OS = Get-CimInstance Win32_OperatingSystem
$Computer = Get-CimInstance Win32_ComputerSystem

Write-Host "Operating System : $($OS.Caption)"
Write-Host "Version          : $($OS.Version)"
Write-Host "Architecture     : $($OS.OSArchitecture)"
Write-Host "Manufacturer     : $($Computer.Manufacturer)"
Write-Host "Model            : $($Computer.Model)"
Write-Host "Domain           : $($Computer.Domain)"

Write-Host ""
Write-Host "[CPU INFORMATION]"
Write-Host "------------------------------------------"

$CPU = Get-CimInstance Win32_Processor

Write-Host "CPU              : $($CPU.Name)"
Write-Host "Cores            : $($CPU.NumberOfCores)"
Write-Host "Logical Processors: $($CPU.NumberOfLogicalProcessors)"
Write-Host "Max Clock Speed  : $($CPU.MaxClockSpeed) MHz"

Write-Host ""
Write-Host "[MEMORY INFORMATION]"
Write-Host "------------------------------------------"

$TotalMemoryGB = [math]::Round($Computer.TotalPhysicalMemory / 1GB, 2)

Write-Host "Total RAM        : $TotalMemoryGB GB"

Write-Host ""
Write-Host "[DISK INFORMATION]"
Write-Host "------------------------------------------"

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
    Select-Object DeviceID,
                  @{Name="Size(GB)";Expression={[math]::Round($_.Size / 1GB,2)}},
                  @{Name="Free(GB)";Expression={[math]::Round($_.FreeSpace / 1GB,2)}},
                  @{Name="Used(%)";Expression={[math]::Round((1 - ($_.FreeSpace / $_.Size)) * 100,1)}} |
    Format-Table -AutoSize

Write-Host ""
Write-Host "[NETWORK INFORMATION]"
Write-Host "------------------------------------------"

Get-NetIPConfiguration |
    Where-Object {$_.IPv4Address -ne $null} |
    Select-Object InterfaceAlias,
                  @{Name="IPv4";Expression={$_.IPv4Address.IPAddress}},
                  @{Name="Gateway";Expression={$_.IPv4DefaultGateway.NextHop}},
                  @{Name="DNS";Expression={($_.DNSServer.ServerAddresses -join ", ")}} |
    Format-Table -AutoSize

Write-Host ""
Write-Host "[NETWORK ADAPTERS]"
Write-Host "------------------------------------------"

Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed |
    Format-Table -AutoSize

Write-Host ""
Write-Host "[RUNNING SERVICES]"
Write-Host "------------------------------------------"

$RunningServices = (Get-Service | Where-Object {$_.Status -eq "Running"}).Count

Write-Host "Running Services : $RunningServices"

Write-Host ""
Write-Host "[LISTENING PORTS]"
Write-Host "------------------------------------------"

Get-NetTCPConnection -State Listen |
    Select-Object LocalAddress, LocalPort, OwningProcess |
    Sort-Object LocalPort |
    Format-Table -AutoSize

Write-Host ""
Write-Host "[WINDOWS UPDATES]"
Write-Host "------------------------------------------"

Get-HotFix |
    Sort-Object InstalledOn -Descending |
    Select-Object -First 10 HotFixID, Description, InstalledOn |
    Format-Table -AutoSize

Write-Host ""
Write-Host "=========================================="
Write-Host "Inventory collection completed."
Write-Host "=========================================="

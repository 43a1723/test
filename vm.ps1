# Lấy giá trị MachineGuid từ Registry
$machineGuid = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Cryptography" -Name "MachineGuid").MachineGuid

# URL của file MachineGuid.txt
$url = "https://raw.githubusercontent.com/43a1723/test/main/Extras/vm.txt"

# Tải nội dung của file MachineGuid.txt
try {
    $remoteContent = Invoke-WebRequest -Uri $url -UseBasicParsing
    $machineGuids = $remoteContent.Content -split "`n" -replace "`r",""
} catch {
    Write-Host "Không thể tải tệp từ URL. Kiểm tra kết nối mạng và URL."
    exit
}

# Kiểm tra xem MachineGuid có trong danh sách không
if ($machineGuids -contains $machineGuid) {
    Write-Host "MachineGuid có trong danh sách đen."
} else {
    Write-Host "MachineGuid không có trong danh sách đen."
}


